# hardware-specific folder

This folder is for hardware/machine specific settings and it's folder structure is intended to allow and easy/standard way that a single user can manage also
multi machine configurations.

The default name of this very folder is "default-machine-name", be free to rename it or add addtional sibling folders, knowing that you also have to update the symlink `configuration-machine-specific.nix` in such a case to point to the respective machine.

By using one folder per hardware/machine, we can achieve
- a basic config that should be available on all machines (that is in the parent of the machine-specific folders).
- machine specific settings in the hardware subfolder (per machine).
