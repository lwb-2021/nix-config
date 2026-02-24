{
  config,
  lib,
  pkgs,
  ...
}:
{

  imports = [
    ./preclude.nix
    ./rclone.nix
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
    };
  };
  config = {
    home.persistence = {
      "/nix/persistence" = {
        hideMounts = true;
        directories = [

        ]
        ++ config.data.persistence.directories;
        files = [

        ]
        ++ config.data.persistence.files;
      };
      "/nix/local" = {
        hideMounts = true;
        directories = [
          ".cache/rclone"
        ]
        ++ config.data.local.directories;
        files = [
        ]
        ++ config.data.local.files;
      };
    };

    services.restic = {
      enable = true;
      backups = {
        home-data = {
          initialize = true;
          passwordFile = config.sops.secrets."restic/password".path;
          paths = [
            "/nix/persistence/home/${config.home.username}"
          ];
          repository = "rclone:remote-raw:备份/home/${config.home.username}";
          extraBackupArgs = [ "--compression auto" ];
          pruneOpts = [ "--keep-last 4" ];
        };
      };
    };

  };
}
