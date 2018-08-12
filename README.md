frangiclave-mod-repository
==========================

*A collection of Frangiclave-enhanced mods for Cultist Simulator.*

This is a community repository of mods for Cultist Simulator that depend on [frangiclave-patch](https://gitlab.com/frangiclave/frangiclave-patch) to work and which should be applied with [frangiclave-mod-manager](https://gitlab.com/frangiclave/frangiclave-mod-manager)

License: All mods are the sole property of their authors. By contributing your mod to this repository, you agree to give us permission to redistribute it.

## Submitting a mod

If you have created a mod that you wish to submit to the repository, follow these steps (you will need to have installed and configured Git on your machine):

1. [Create a Gitlab account, or sign in to your existing one.](https://gitlab.com/users/sign_in)
2. [Fork the repository.](https://gitlab.com/frangiclave/frangiclave-mod-repository/forks/new) As a best practice, you should keep this repository up-to-date with the main one, to avoid potential conflicts.
3. Clone the newly-created repository to your machine.
4. Add your mod's files in a new folder in the `mods/<mod_name>/<version>` directory, where `<mod_name>` is a unique name for your mod's folder and `<version>` is the corresponding version of your mod.
5. Push your changes to your repository (either on the master branch or another branch of your choosing).
6. [Submit a merge request](https://gitlab.com/frangiclave/frangiclave-mod-repository/merge_requests/new) which adds your mod's files to the repository and wait for it to be reviewed.
   * Each merge request should only ever add or update a single mod, and should only affect files of a mod you own.
   * Your mod should have a fully-detailed manifest and correctly-formatted content files to be approved.

Once a mod is added to the repository, it can then be downloaded and applied by the mod manager at any time.

### Updating

Whenever you make changes to your mod that you wish to publish, submit a new merge request with the updated files and a newer version number.

Version numbers should be of the form `MAJOR.MINOR.PATCH`. You should increment each number as follows:

- `MAJOR` when there are big, breaking change, for any mods that might depend on this one,
- `MINOR` when you add functionality that keeps the mod backwards-compatible,
- `PATCH` when you add backwards-compatible bug fixes.

The requirement to adhere to these rules is not always strictly enforced, but you should try to stick to them where possible for clarity.