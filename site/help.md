---
layout: page
title: Help
permalink: /help/
---

## Getting Started

Getting up and running with Frangiclave mods is really easy! Just follow the following steps:

1. Download the latest version of the Frangiclave Mod Manager from the [Tools](/tools/) page.
    * On Linux and macOS, you will also need to install [Mono](https://www.mono-project.com/download/stable/) to be able to run it.
2. Extract it anywhere on your computer.
3. Run `FrangiclaveModManager.exe`, either by double-clicking (Windows) on typing `mono FrangiclaveModManager.exe` (Linux and macOS).
4. On first run it, the program will prompt you to input the location of your Cultist Simulator game directory. Do so, and it will remember it for later attempts.
5. The program should now patch your game.
    * You will need to re-run this step every time the game is updated.
5. If patching was successful, you're all set! You can now install mods by dropping them into your game's `StreamingAssets/mods/` folder (create it if it doesn't exist).

## Using the Mod Manager

Once the mod manager has patched the game, you can install mods by dropping them into your game's `StreamingAssets/mods/`. You will see all loaded mods on the game's main menu, as pictured below.

![Frangiclave](/assets/mod_panel_demo.png){:style="display: block; margin: 0 auto; max-width: 800px; width: 100%;"}

## Creating a Mod

In order to create a mod, you will need to put your files in a folder with the following structure:

- `/manifest.json`: a JSON file providing metadata (author, version, etc.) for your mod. If your mod requires entities definend in other mods, list them in the `dependencies` section. See the demo mod for an example.
- `/content/`: any number of content files, eventually in their own subdirectories. One file can contain different types of entities, such as events and recipes. Valid entities are: `decks`, `elements`, `endings` (NEW), `legacies`, `maps` (NEW), `recipes`, `verbs`.
  - NEW: entities can override core files. Simply use the same ID to override existing entities.
  - NEW: entities can delete core files by specifying `deleted: true` in their definition. All other properties are ignored.
  - NEW: entities (except for `endings` and `maps`) can now extend any number of other entities, inheriting their existing properties. You can do so through the `extend` property, which should be given an array of IDs to inherit from. **Example:** `"extends": ["element_a", "element_b", "element_c"]`.
    - For finer extensions of the individual properties, you can specify property operations. The format for these operations is `<property>$<operation>`, where `<property>` is the name of the property to operate on, and `<operation>` is the operation to apply. The following operations are available:
      - `$append`: appends a list of items to the original list property.
      - `$prepend`: prepends a list of items to the original list property.
      - `$plus`: adds the specified number to the original number property.
      - `$minus`: subtracts the specified number from the original number property.
      - `$extend`: extends a dictionary with the specified properties.
      - `$remove`: removes each element in the list from the original property, which can either be a list or a dictionary.
- `/images/`: image files for the game, organized into appropriate sub-directories. Valid sub-directories are: `cardBacks/`, `elementArt/`, `elementArt/anim/`, `endingArt/`, `icons40/aspects/`, `icons100/legacies/`, `icons100/verbs/`, `maps/`, `maps/portals/`.

Once you are ready to distribute your mod, see the [Submit](/submit/) page.

For examples, see the [Demo Mod](/mods/demo_mod/), which makes use of all of these features.
