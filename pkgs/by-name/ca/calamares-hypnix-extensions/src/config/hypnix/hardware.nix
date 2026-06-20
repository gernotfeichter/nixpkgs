{ config, lib, pkgs, ... }:
{
  hardware.enableAllFirmware = true; # allows all licenses

  services.printing = {
    enable = true;
    drivers = [
      pkgs.gutenprint
      pkgs.gutenprintBin
      pkgs.hplip
      pkgs.hplipWithPlugin
      pkgs.postscript-lexmark
      pkgs.samsung-unified-linux-driver
      pkgs.splix
      pkgs.brlaser
      pkgs.brgenml1lpr
      pkgs.brgenml1cupswrapper
      pkgs.cnijfilter2
    ];
  };

  services.ntp.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Configure console keymap
  # console.useXkbConfig is disabled to prevent conflicts with explicitly provided console.keyMap from Calamares
  # console.useXkbConfig = true;
}
