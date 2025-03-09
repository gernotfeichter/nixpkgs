{ config, lib, pkgs, ... }:
{
  users.users."${config.hypnix.standardUser}".packages = with pkgs; [
      # For a list of available packages,see: https://search.nixos.org/packages
      firefox
      google-chrome
      libreoffice-qt
      vlc
      wev
      playerctl
      wlsunset
      gimp
      hyprshot
      inkscape
   ];
}
