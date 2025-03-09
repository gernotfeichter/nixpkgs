# hpynix config directory hierarchy

```yaml
/etc/nixos
  - hardware/default-machine-name
    - clevis-luks.nix # not enabled per default, allows unlocking the encrypted system partition without typing a password
    - configuration.nix # original NixOS main/root config file (e.g. loads hardware-confugration.nix)
    - hardware-configuration.nix # original NixOS hardware-confugration.nix
    - default.nix # hardware specific main/root -> This one loads all other configs
    - networking.nix # uses networkmanager per default for notworking, feel free to switch to different networking options.
    - nvidia.nix # Nvidia graphics card related settings. Details in the file.
  - configuration-machine-specific.nix # symlink to hardware/default-machine-name/default.nix (=default) or to another machine specific folder with same conventions (see below for details on that)
  - configuration.nix # main/root -> This one loads all other configs, incl. hypnix and original NixOS files
  - packages.nix # install packages for specific users or all users
  - hardware.nix # global variant of hardware-configuration.nix (see above)
```
