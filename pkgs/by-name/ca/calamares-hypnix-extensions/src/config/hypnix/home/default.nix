{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.extraSpecialArgs = { isLiveCD = config.hypnix.isLiveCD; };

  home-manager.users.${config.hypnix.standardUser} = import ./home.nix;
}
