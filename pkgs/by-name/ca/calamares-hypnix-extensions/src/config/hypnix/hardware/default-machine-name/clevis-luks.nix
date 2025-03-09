{ config, lib, pkgs, boot, ... }:
let
  enabled = false;
  interfaceWifi = "wlp0s20u5";
  interfaceEth = "enp7s0";
  luksDeviceList = builtins.attrNames config.boot.initrd.luks.devices;
in {
  config = lib.mkIf enabled {
    # dhcp
    networking.interfaces."${interfaceWifi}".useDHCP = true;
    networking.interfaces."${interfaceEth}".useDHCP = true;

    # initrd general
    boot.initrd.verbose = true;
    boot.initrd.enable = true;

    # networking
    boot.initrd.systemd.enable = true;
    boot.initrd.network.enable = true;
    boot.initrd.systemd.network.enable = true;
    boot.initrd.systemd.network.wait-online.enable = true;
    boot.initrd.systemd.emergencyAccess = true;
    boot.initrd.systemd.initrdBin = [ pkgs.wpa_supplicant pkgs.coreutils pkgs.systemd ];

    # clevis
    boot.initrd.clevis.enable = true;
    boot.initrd.clevis.useTang = true;
    boot.initrd.clevis.devices = lib.genAttrs luksDeviceList (name: { secretFile = secrets/luks.jwe; });
    boot.initrd.systemd.users.root.shell = "${pkgs.bash}/bin/bash";

    # wifi
    # https://discourse.nixos.org/t/wireless-connection-within-initrd/38317/13
    boot.initrd.systemd.packages = [ pkgs.wpa_supplicant ];
    boot.initrd.systemd.targets.initrd.wants = [ "wpa_supplicant@${interfaceWifi}.service" "systemd-resolved.service" ];
    boot.initrd.systemd.services."wpa_supplicant@".unitConfig.DefaultDependencies = false;
    boot.initrd.secrets."/etc/wpa_supplicant/wpa_supplicant-${interfaceWifi}.conf" = secrets/wpa_supplicant.conf;

    # ethernet
    boot.initrd.systemd.network.networks."10-eth" = {
      matchConfig.Name = interfaceEth;
      networkConfig.DHCP = "yes";
    };

    # dns
    boot.initrd.services.resolved.enable = true;
  };
}
