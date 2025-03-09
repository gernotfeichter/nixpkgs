{ config, pkgs, lib, ... }:
let
  # 1. The original package we are mirroring
  baseHyprland = pkgs.hyprland;

  # 2. Merge the binary and the plugin
  hyprlandWrapped = pkgs.symlinkJoin {
    name = "hyprland-with-plugins-${baseHyprland.version}";
    paths = [
      baseHyprland
      pkgs.hyprlandPlugins.hyprgrass
    ];

    # 3. Inherit the metadata the module is hunting for
    passthru = baseHyprland.passthru // {
      providedSessions = [ "hyprland" ];
    };
  };

  # 4. Inject the version and the override function
  finalHyprland = (lib.makeOverridable (args: hyprlandWrapped) {}).overrideAttrs (old: {
    inherit (baseHyprland) version;
  });
in
{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "sudo"
          "git"
          "kubectl"
          "helm"
          "docker"
        ];
      };
      shellAliases = {
        v = "nvim";
	      vi = "nvim";
      };
    };
    neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;
      viAlias = true;
      defaultEditor = true;
      configure = {
        #customRC = ''
        #  set clipboard=unnamedplus
        #'';
      };
    };
    nm-applet = {
      enable = true;
    };
    hyprland = {
      enable = true;
      package = finalHyprland;
    };
  };
}

