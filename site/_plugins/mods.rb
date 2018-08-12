require 'fileutils'
require 'semantic'
require 'zip'

module Jekyll
  class ModPage < Page
    def initialize(site, base, dir, manifest)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      process(@name)
      read_yaml(File.join(base, '_layouts'), 'mod.html')
      data['mod'] = manifest
      data['title'] = 'Mod - ' + manifest['name']
    end
  end

  class ModsPageGenerator < Jekyll::Generator
    def generate(site)
      manifests = []

      # Load all the mod definitions
      Dir.glob '../mods/*/' do |versions_path|
        # Use the data from the latest version as the authoritative source
        mod_id = File.basename(versions_path)
        latest_version = nil
        Dir.glob File.join(versions_path, '*.*.*') do |version_path|
          version = Semantic::Version.new File.basename(version_path)
          if latest_version.nil? || latest_version < version
            latest_version = version
          end
        end
        next if latest_version.nil?

        # Parse the manifest
        manifest = JSON.parse(
          File.read(
            File.join(versions_path, latest_version.to_s, 'manifest.json')
          )
        )
        manifest['id'] = mod_id
        manifests << manifest

        # Add a page with the mod details
        mod_dir = File.join('/mods/', mod_id)
        page = ModPage.new(site, site.source, mod_dir, manifest)
        site.pages << page
      end

      # Update the Mods page with a list of mods
      mods = site.pages.detect { |page| page.name == 'mods.md' }
      mods.data['mods'] = manifests
    end
  end

  class ZipFileGenerator
    def initialize(input_dir, output_file)
      @input_dir = input_dir
      @output_file = output_file
    end

    def write
      entries = Dir.entries(@input_dir) - %w[. ..]

      File.delete(@output_file) if File.exist?(@output_file)
      ::Zip::File.open(@output_file, ::Zip::File::CREATE) do |zipfile|
        zipfile.mkdir File.basename(File.dirname(@input_dir))
        write_entries entries, '', zipfile
      end
    end

    private

    def write_entries(entries, path, zipfile)
      entries.each do |e|
        zipfile_path = path == '' ? e : File.join(path, e)
        disk_file_path = File.join(@input_dir, zipfile_path)

        if File.directory? disk_file_path
          recursively_deflate_directory(disk_file_path, zipfile, zipfile_path)
        else
          put_into_archive(disk_file_path, zipfile, zipfile_path)
        end
      end
    end

    def recursively_deflate_directory(disk_file_path, zipfile, zipfile_path)
      zipfile.mkdir File.join(File.basename(File.dirname(@input_dir)), zipfile_path)
      subdir = Dir.entries(disk_file_path) - %w[. ..]
      write_entries subdir, zipfile_path, zipfile
    end

    def put_into_archive(disk_file_path, zipfile, zipfile_path)
      zipfile.get_output_stream(File.join(File.basename(File.dirname(@input_dir)), zipfile_path)) do |f|
        f.write(File.open(disk_file_path, 'rb').read)
      end
    end
  end

  Jekyll::Hooks.register :site, :post_write do |site, _|
    # Create a ZIP archive for every mod's version
    Dir.glob '../mods/*' do |mod_path|
      mod_id = File.basename(mod_path)
      zip_dir = site.in_dest_dir(File.join('downloads', mod_id))
      FileUtils.mkdir_p(zip_dir) unless File.directory?(zip_dir)
      Dir.glob File.join(mod_path, '*.*.*') do |version_path|
        version = File.basename version_path
        zf = ZipFileGenerator.new(
          version_path,
          File.join(zip_dir, "#{mod_id}-#{version}.zip")
        )
        zf.write
      end
    end
  end
end