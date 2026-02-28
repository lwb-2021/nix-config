{ config, ... }:
{
  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ./files/home.yaml;
    secrets = {
      "rclone/crypt/password" = { };
      "rclone/jianguoyun/password" = { };
      "rclone/onedrive/client-id" = { };
      "rclone/onedrive/client-secret" = { };
      "rclone/onedrive/token" = { };
      "restic/password" = { };
      "anki/password" = { };
      "vicinae/nix/github-token" = { };

      "ssh/keys/github" = { };
      "syncthing/passwords/backup" = { };
    };
  };

}
