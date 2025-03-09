# hypnix

First hyprland baked iso-installable linux distro (or pseudo-distro), since this is 100% nixos but with a different default config!

Hypnix is a fork of https://github.com/nixos/nixpkgs and only contains the required code and base config to produce a bootable ISO image,
which the user can use as live system or to install the linux distro on a permanent disk.

# build

To build the iso, run the follwing command in the nixos subdir:
`nix-build -A config.system.build.isoImage -I nixos-config=modules/installer/cd-dvd/installation-cd-graphical-hypnix.nix`.

NOTE down the ISO_FILE_PATH, the line that contains it, looks like this: Writing to 'stdio:/nix/store/1wg14npymm483vxz7xmyiszqd4fnzvcb-nixos-24.11pre-git-x86_64-linux.iso/iso/nixos-24.11pre-git-x86_64-linux.iso' completed successfully.


