{ ... }:
{
  security = {
    sudo = {
      enable = true;
      extraConfig = ''
        Defaults pwfeedback
      '';
    };
  };


  networking.firewall =
    let
      kdeconnect = {
        from = 1714;
        to = 1764;
      };

    in
    {
      enable = true;
      allowedTCPPortRanges = [
        kdeconnect
      ];
      allowedUDPPortRanges = [
        kdeconnect
      ];
      allowedTCPPorts = [
        22000 # Syncthing
      ];
      allowedUDPPorts = [
        22000 # Syncthing
        21027 # Syncthing discovery
      ];
    };

}
