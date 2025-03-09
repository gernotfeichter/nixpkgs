{ pkgs, lib, ... }:

{
  imports = [
    # Base installer config, brings in nixos user, polkit rules, etc.
    ./installation-cd-graphical-calamares.nix

    # The main hypnix configuration.
    # This will configure the live system to be a hypnix system.
    ../../../../pkgs/by-name/ca/calamares-hypnix-extensions/src/config/hypnix/configuration.nix
  ];

  # Configure hypnix for the live CD user
  hypnix.standardUser = lib.mkForce "nixos";
  hypnix.isLiveCD = true;

  # Use the overlay to get the custom calamares extensions
  # This is still needed so that the installer running on the live CD
  # is the one with the hypnix extensions.
  nixpkgs.overlays = [
    (self: super: {
      calamares-nixos-extensions = self.callPackage ../../../../pkgs/by-name/ca/calamares-hypnix-extensions/package.nix {};
    })
  ];

  # Disable vmware guest additions for the livecd, as it causes issues.
  virtualisation.vmware.guest.enable = lib.mkForce(false);

  # Autologin is handled by the hypnix config's displaymanager.nix,
  # but we need to ensure it's enabled and set to the right user.
  # The imported hypnix config already enables autologin for `config.hypnix.standardUser`.
  # Since we set `hypnix.standardUser = "nixos"`, this should work.
}
