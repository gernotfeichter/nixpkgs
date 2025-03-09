{ config, lib, pkgs, ... }:

{

  imports = [
    ./home/default.nix
    ./hardware.nix
    ./configuration-machine-specific.nix
    ./packages-system.nix
    ./packages-user.nix
    ./programs.nix
    ./displaymanager.nix
    ./modules/hypnix.nix
  ];

  config = {
    users.defaultUserShell = pkgs.zsh;
    boot.loader.systemd-boot.configurationLimit = 5;
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 90d";
    };
    nixpkgs.config.permittedInsecurePackages = [
      "mbedtls-2.28.10"
    ];
    nixpkgs.config.allowUnfree = true;
    hypnix.standardUser = "@@username@@"; # warning: do not change this, especially if you have no /etc/passwd entry!
};

}
