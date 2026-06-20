{ config, lib, pkgs, ... }:
{
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "${config.hypnix.standardUser}";
    };
    defaultSession = "hyprland";
    dms-greeter = {
      enable = true;
      compositor.name = "hyprland";
    };
  };
}