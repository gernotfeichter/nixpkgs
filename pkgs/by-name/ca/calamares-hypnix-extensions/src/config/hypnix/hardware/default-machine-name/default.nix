{ config, lib, ... }:

{

  imports = [
    ./alp.nix
    ./clevis-luks.nix
    ./networking.nix
    ./nvidia.nix
  ] ++ (lib.optional (builtins.pathExists ./configuration.nix) ./configuration.nix);

}