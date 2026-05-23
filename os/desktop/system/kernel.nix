{ config, pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
    extraModulePackages = with config.boot.kernelPackages; [
      nvidiaPackages.stable
      v4l2loopback
    ];
  };

}
