{ config, lib, pkgs, ... }:

let
  filePathAllKernelModulePaths = "${config.system.modulesTree.outPath}/lib/modules/${config.boot.kernelPackages.kernel.version}/modules.order";
  fileAllKernelModulePaths = builtins.readFile filePathAllKernelModulePaths;
  kernelModulePathsSplitters = pkgs.lib.splitString "\n" fileAllKernelModulePaths;
  kernelModulePaths = builtins.filter (x: x != "") kernelModulePathsSplitters;
  allKernelModulesList = map (x: builtins.elemAt (pkgs.lib.match ".*/(.*)\.ko" x) 0) kernelModulePaths;
in
{
  options.hypnix = {
    standardUser = lib.mkOption {
      type = lib.types.str;
      description = ''
        The standard user name (not root) of the nixos multi-user installation.
      '';
      default = false;
    };

    isLiveCD = lib.mkOption {
      type = lib.types.bool;
      description = "Whether the system is running as a live CD.";
      default = false;
    };
  };

  config.boot.initrd.availableKernelModules = allKernelModulesList;
}

