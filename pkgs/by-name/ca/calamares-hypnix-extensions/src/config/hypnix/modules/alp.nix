{ config, pkgs, lib, ... }:

let
  cfg = config.services.pam.alp;

  alpAuthLine = ''
    # https://github.com/gernotfeichter/alp
    auth sufficient pam_exec.so stdout /run/wrappers/bin/alp auth
  '';
in
{
  options.services.pam.alp = {
    enable = lib.mkEnableOption "Alp PAM configuration";

    keyFile = lib.mkOption {
      type = lib.types.path;
      description = ''
        Path to a local file containing the secret key.
        This file should be outside the Nix store.
      '';
    };

    targets = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "_gateway:7654" ];
      description = "List of targets (IP:Port or Hostname:Port) for Alp.";
    };

    enableSudo = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable alp for the sudo command.";
    };

    enableLogin = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable alp for the login command.";
    };

    enableSddm = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable alp for sddm (display manager).";
    };

    enableDmsGreeter = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable alp for dms-greeter.";
    };

    enableGreetd = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable alp for greetd.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Create the directory with secure permissions
    systemd.tmpfiles.rules = [
      "d /etc/alp 0700 root root -"
    ];

    # Activation script to generate alp.yaml securely
    system.activationScripts.alpConfig = {
      deps = [ "stdio" ];
      text = ''
        if [ -f "${cfg.keyFile}" ]; then
          SECRET_KEY=$(cat "${cfg.keyFile}")

          # Generate the YAML file
          mkdir -p /etc/alp
          cat <<EOF > /etc/alp/alp.yaml
---
key: "$SECRET_KEY"
targets:
${lib.concatMapStringsSep "\n" (t: "  - ${t}") cfg.targets}
EOF
          chmod 600 /etc/alp/alp.yaml
        else
          echo "Warning: alp keyFile ${cfg.keyFile} not found. alp.yaml not generated." >&2
        fi
      '';
    };

    security.wrappers.alp = {
      setuid = true;
      owner = "root";
      group = "root";
      source = "${pkgs.alp}/bin/alp";
    };

    security.pam.services = {
      sudo.text = lib.mkIf cfg.enableSudo (lib.mkDefault (lib.mkBefore alpAuthLine));
      login.text = lib.mkIf cfg.enableLogin (lib.mkDefault (lib.mkBefore alpAuthLine));
      sddm.text = lib.mkIf cfg.enableSddm (lib.mkBefore alpAuthLine);
      "dms-greeter".text = lib.mkIf cfg.enableDmsGreeter (lib.mkDefault (lib.mkBefore alpAuthLine));
      greetd.text = lib.mkIf cfg.enableGreetd (lib.mkDefault (lib.mkBefore alpAuthLine));
    };

    environment.systemPackages = [ pkgs.alp ];
  };
}
