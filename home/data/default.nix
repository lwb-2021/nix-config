{ config, lib, ... }:
{

  imports = [
    ./preclude.nix
    ./rclone.nix
    ./syncthing.nix
  ];

  options = with lib; {
    data = {
      persistence = {
        directories = mkOption {
          type = types.listOf types.anything;
        };
        files = mkOption {
          type = types.listOf types.anything;
        };
      };
      local = {
        directories = mkOption {
          type = types.listOf types.anything;
        };
        files = mkOption {
          type = types.listOf types.anything;
        };
      };

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
    home.persistence = {
      "/data/persistence" = {
        hideMounts = true;
        directories = config.data.persistence.directories;
        files = config.data.persistence.files;
      };
      "/data/local" = {
        hideMounts = true;
        directories = config.data.local.directories;
        files = config.data.local.files;
      };

    };

    services.restic = {
      enable = true;
      backups = {
        home-data = {
          initialize = true;
          passwordFile = config.sops.secrets."restic/password".path;
          paths = [
            "/data/persistence/home/${config.home.username}"
          ];
          repository = "rclone:remote-raw:备份/home/${config.home.username}";
          extraBackupArgs = [ "--compression auto" ];
          pruneOpts = [ "--keep-last 4" ];
        };
      };
    };

  };
}
