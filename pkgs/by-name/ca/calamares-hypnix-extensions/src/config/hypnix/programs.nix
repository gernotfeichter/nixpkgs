{ config, pkgs, lib, ... }:
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
    };
  };
}

