{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.syncthing = {
    enable = true;
    #overrideDevices = false;
    settings = rec {
      devices = {
        "phone" = {
          id = "3BI7JEJ-BWL5V3R-SSHNDPI-JNR5FCU-3YPHXKL-ZQSFKD5-P36NRWQ-RIRGLQ2";
          addresses = [
            "tcp://10.126.126.254:22000"
            "dynamic"
          ];
        };
      };
      folders =
        lib.genAttrs (builtins.map (x: "~/" + x) config.data.sync.folders) (name: {
          id = lib.toLower (builtins.baseNameOf name);
          devices = [ "phone" ];
        })
        // {
          "~/Documents/Syncthing" = {
            id = "default";
            devices = [ "phone" ];
          };
          "/data/backup" = {
            id = "backups";

            devices = builtins.map (name: {
              inherit name;
              encryptionPasswordFile = config.sops.secrets."syncthing/passwords/backup".path;
            }) (builtins.attrNames devices);
          };
        };

    };
  };

}
