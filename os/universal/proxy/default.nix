{ pkgs, ... }:
{
  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = ./mihomo-config.yaml;
  };
  networking.firewall = {
    trustedInterfaces = [ "tun0" ];
    checkReversePath = "loose"; # Important
  };
  environment.systemPackages = [
    (pkgs.makeDesktopItem {
      desktopName = "Mihomo WebUI";
      name = "mihomo-webui";
      url = "http://127.0.0.1:9090/ui/#";
      icon = "preferences-system-network-proxy";
      type = "Link";
    })
  ];
}
