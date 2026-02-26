{ config, ... }:
{
  data.local.directories = [
    ".cache/rclone"
  ];

  programs.rclone = {
    enable = true;
    remotes = {
      remote = {
        config = {
          type = "compress";
          compress-mode = "zstd";
          remote = "remote-encrypted:/";
        };
        mounts = {
          "" = {
            mountPoint = "${config.home.homeDirectory}/Cloud";
            options = {
              fuse-flag = "x-gvfs-hide";
            };
          };
        };
      };

      remote-encrypted = {
        config = {
          type = "crypt";
          remote = "remote-raw:加密数据";
        };
        secrets.password = config.sops.secrets."rclone/crypt/password".path;
      };
      remote-raw = {
        config = {
          type = "union";
          upstreams = "onedrive:/ jianguoyun:/:writeback";
          # type = "alias";
          # remote = "onedrive:/";
        };
      };
      jianguoyun = {
        config = {
          type = "webdav";
          url = "https://dav.jianguoyun.com/dav/";
          user = "lwb-2021@qq.com";
          vendor = "other";
        };
        secrets.pass = config.sops.secrets."rclone/jianguoyun/password".path;
      };
      onedrive = {
        config = {
          type = "onedrive";
          drive_id = "1D73A20E66440310";
          drive_type = "personal";
        };
        secrets = {
          client_id = config.sops.secrets."rclone/onedrive/client-id".path;
          client_secret = config.sops.secrets."rclone/onedrive/client-secret".path;
          token = config.sops.secrets."rclone/onedrive/token".path;
        };

      };
    };
  };
}
