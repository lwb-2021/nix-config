{ ... }:
{
  imports = [
    # TODO https://github.com/NixOS/nixpkgs/pull/470366
    (builtins.fetchurl {
      url = "https://github.com/luochen1990/nixpkgs/raw/9bcddd22fd5454aaa97345975837518686dd658c/nixos/modules/system/boot/zswap.nix";
      sha256 = "sha256:000m59zjk1qfwn9z09i0k1ajv6knv75cri91575ikqfg6r0fhs0g";
    })
  ];
  services.upower = {
    enable = true;
  };
  # writebackDevice = "/dev/disk/by-uuid/ff5a2b4e-a5b6-4c72-a05e-2d41b02f1794";

  boot.zswap = {
    enable = true;
    compressor = "zstd";
    zpool = "zsmalloc";
    maxPoolPercent = 25;
    shrinkerEnabled = true;
  };

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;

    "vm.swappiness" = 80;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
    "vm.dirty_bytes" = 268435456;
    "vm.dirty_background_bytes" = 134217728;
    "vm.max_map_count" = 2147483642;
    "fs.inotify.max_user_instances" = 1024;

    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
