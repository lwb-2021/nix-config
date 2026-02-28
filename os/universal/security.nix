{ config, lib, ... }:
{
  security = {
    sudo = {
      enable = true;
    };

    pam.services =
      let
        gpg = {
          gnupg = {
            enable = true;
            storeOnly = true;
            noAutostart = true;
          };
        };
      in
      {
        login = {
        }
        // gpg;
        greetd = {
        }
        // gpg;
      };
  };

  networking.firewall =
    let
      syncthing = 22000;
      syncthing-discovery = 21027;
      kdeconnect = {
        from = 1714;
        to = 1764;
      };
    in
    {
      enable = true;
      allowedTCPPorts = [ syncthing ];
      allowedUDPPorts = [
        syncthing
        syncthing-discovery
      ];
      allowedTCPPortRanges = [
        kdeconnect
      ];
      allowedUDPPortRanges = [
        kdeconnect
      ];
    };

}
