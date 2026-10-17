{ config, lib, ... }:
{

  imports = [
    ./preclude.nix
    ./rclone.nix
    ./syncthing.nix
  ];

  # data.persistence / data.local are declared by the persistence aspect
  # (modules/aspects/persistence) and fed into preservation on the NixOS side.
  options = with lib; {
    data = {
      sync = {
        folders = mkOption {
          type = types.listOf types.str;
        };
        syncthing = {
          targets = mkOption {
            type = types.listOf types.str;
          };
        };
      };
    };
  };
  config = {
    services.restic = {
      enable = true;
      backups = {
        home-data = {
          initialize = true;
          passwordFile = config.sops.secrets."restic/password".path;
          paths = [
            "/data/persistence/home/${config.home.username}"
          ];
          exclude = [
            ".direnv"
            "target/debug/*"
            "target/release/*"
          ];
          repository = "/data/backup/home/${config.home.username}";
          extraBackupArgs = [ "--compression auto" ];
          pruneOpts = [ "--keep-last 4" ];
        };
      };
    };
  };
}
