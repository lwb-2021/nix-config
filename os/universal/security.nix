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

  services.syncthing.openDefaultPorts = true;

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
    };

}
