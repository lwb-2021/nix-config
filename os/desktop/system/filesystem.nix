{ lib, ... }:
{
  fileSystems."/" = lib.mkForce {
    device = "tmpfs";
    fsType = "tmpfs";
    # 必须设置 mode=755，否则默认的权限将是 777，导致 OpenSSH 报错并拒绝用户登录
    options = [
      "relatime"
      "mode=755"
    ];
  };

  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  preservation.preserveAt."/data/persistence/system" = {
    directories = [
      {
        directory = "/root";
        mode = "0700";
      }
    ];

    files = [
      {
        file = "/etc/machine-id";
        inInitrd = true;
      }
      "/etc/ssh/ssh_host_ed25519_key.pub"
      {
        file = "/etc/ssh/ssh_host_ed25519_key";
        mode = "0600"; # sshd refuses world-readable host keys
      }
      "/etc/ssh/ssh_host_rsa_key.pub"
      {
        file = "/etc/ssh/ssh_host_rsa_key";
        mode = "0600";
      }
    ];
  };

  environment.variables.NIX_REMOTE = "daemon";

  systemd.services.nix-daemon = {
    serviceConfig = {
      CacheDirectory = "nix";
    };
  };
  systemd.tmpfiles.rules = [
    "d /data/backup 0777 root root -"
  ];

  services.btrfs.autoScrub = {
    enable = true;
    interval = "daily";
  };

}
