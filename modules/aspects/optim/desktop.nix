{ ... }: {
  flake.aspects.optim-desktop = {
    nixos = { pkgs, ... }: {
      boot.kernelPackages = pkgs.linuxPackages_cachyos;
      hardware.nvidia.package = pkgs.nvidia_cachyos;

      services.scx = {
        enable = true;
        scheduler = "scx_bpfland";
      };
      services.ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-rules-cachyos;
      };

      programs.gamemode = {
        enable = true;
      };

      services.udev.extraRules = ''
        ACTION=="add|change", KERNEL=="nvme[0-9]*n[0-9]*", ATTR{queue/scheduler}="kyber"
      '';

      imports = [ ./_universal.nix ];
    };
    hm = { };
  };
}
