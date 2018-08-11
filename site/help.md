---
layout: page
title: Help
permalink: /help/
---

## Getting Started

Getting up and running with Frangiclave mods is really easy! Just follow the following steps:

1. Download the latest version of the Frangiclave Mod Manager from the [Tools](/tools/) page.
2. Copy the file to the root of your game directory, next to the game executable.
3. Run it (usually accomplished by clicking/double-clicking it; some platforms may require that you open it with the terminal).
4. You should arrive at a prompt. Type `p` to patch your game (you will need to do this every time the game is updated).
5. If patching was successful, you're all set! You can now install mods using `i <mod_id>`, where `<mod_id>` is the ID of the mod to install.

## Using the Mod Manager

The mod manager takes the form of a simple command-line application with a few commands:

- `p`: patches the game with the new functionality. Needs to be re-run at every updated. Some updates may require that you download a new version of the patcher to work properly.
- `i <mod_id>`: installs a mod, along with all its required dependencies.
- `u`: updates all your currently installed mods to their latest versions.
- `r <mod_id>`: removes a mod from your game.
- `x`: exits the mod manager.

## Creating a Mod

In order to create a mod, you will need to put your files in a folder with the following structure:

- `/manifest.json`: a JSON file providing metadata (author, version, etc.) for your mod. If your mod requires entities definend in other mods, list them in the `dependencies` section. See the demo mod for an example.
- `/content/`: any number of content files, eventually in their own subdirectories. One file can contain different types of entities, such as events and recipes. Valid entities are: `decks`, `elements`, `endings` (NEW), `legacies`, `recipes`, `verbs`.
  - NEW: entities can override core files. Simply use the same ID to override existing entities.
  - NEW: entities (except for `endings`) can now extend any number of other entities, inheriting their existing properties. You can do so through the `extend` property, which should be given an array of IDs to inherit from. **Example:** `"extends": ["element_a", "element_b", "element_c"]`.
- `/images/`: image files for the game, organized into appropriate sub-directories. Valid sub-directories are: `cardBacks/`, `elementArt/`, `elementArt/anim/`, `endingArt/`, `icons40/aspects/`, `icons100/legacies/`, `icons100/verbs/`.

Once you are ready to distribute your mod, see the [Submit](/submit/) page.