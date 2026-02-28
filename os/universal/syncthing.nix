{ config, lib, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "lwb";
    settings = rec {
      devices = lib.mergeAttrsList (
        builtins.map (homeConfig: homeConfig.services.syncthing.settings.devices) (
          builtins.attrValues config.home-manager.users
        )
      );
      folders = lib.mkMerge (
        (builtins.map (homeConfig: homeConfig.services.syncthing.settings.folders) (
          builtins.attrValues config.home-manager.users
        ))
        ++ [
          {
            "/data/backup" = {
              id = "backups";
              devices = builtins.map (device: {
                name = device;
                encryptionPasswordFile = config.sops.secrets."syncthing/passwords/backup".path;
              }) (builtins.attrNames devices);
            };
          }
        ]
      );
    };
  };
}
