{ config, lib, pkgs, ... }:
{
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "${config.hypnix.standardUser}";
    };
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}