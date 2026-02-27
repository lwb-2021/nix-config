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
