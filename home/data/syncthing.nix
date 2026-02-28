{ config, lib, ... }@params:
{
  services.syncthing = {
    enable = !(params ? osConfig);
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
        lib.genAttrs (builtins.map (path: "${config.home.homeDirectory}/${path}") config.data.sync.folders)
          (folder: {
            id = lib.toLower (builtins.baseNameOf folder);
            devices = config.data.sync.syncthing.targets;
          });
    };
  };

}
