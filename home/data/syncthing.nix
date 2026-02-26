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
    settings = {
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
        };

    };
  };

}
