{ ... }:
{
  systemd.services.nix-daemon.environment = {
    "GOPROXY" = "https://goproxy.cn,direct";
    "NPM_CONFIG_REGISTRY" = "https://registry.npmmirror.com";
  };
}
