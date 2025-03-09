{ config, lib, pkgs, hyprland, ... }:

let wallpaperPath = ../../wallpapers/hyprland_original_wall0.png;
in
{

  home.packages = with pkgs; [ 
    hyprpaper
  ];


  home.file.".config/hypr/hyprpaper.conf".text = ''
preload = ${wallpaperPath}
wallpaper = ,${wallpaperPath}
'';

}
