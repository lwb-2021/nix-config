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
  services.tor = {
    enable = true;
    client.enable = true;
    settings = {
      ExcludeExitNodes = "{cn},{hk},{mo},{sg},{th},{pk},{by},{ru},{ir},{vn},{ph},{my},{cu}";
      ExcludeNodes = "{cn},{hk},{mo},{sg},{th},{pk},{by},{ru},{ir},{vn},{ph},{my},{cu}";
      StrictNodes = 1;
      CircuitBuildTimeout = 5;
      KeepalivePeriod = 60;
      NewCircuitPeriod = 900;
      NumEntryGuards = 8;
      UseBridges = true;
      ClientTransportPlugin = "webtunnel exec ${pkgs.obfs4}/bin/lyrebird";
      Bridge = import ./bridges.nix;
    };
  };
}
