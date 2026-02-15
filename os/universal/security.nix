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

  networking.firewall = {
    enable = true;
    allowedTCPPorts = lib.mkMerge [ ];
  };

}
