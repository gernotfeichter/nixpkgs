{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # For a list of available packages,see: https://search.nixos.org/packages
    networkmanager
    wget
    clevis
    git
    gh
    kitty
    wl-clipboard
    gparted
    alp
    dig
    killall
    brightnessctl
    usbutils
    unzip
    pciutils
  ];
}
