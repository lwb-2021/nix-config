{ ... }:
{
  systemd.services.nix-daemon.environment = {
    "GOPROXY" = "https://goproxy.cn,direct";
  };
}
