{
  config,
  lib,
  pkgs,
  ...
}:
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

  environment.persistence."/data/persistence/system" = {
    hideMounts = true;

    directories = [
      "/etc/NetworkManager/system-connections"
      "/root"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
    ];
  };

  system.etc.overlay = {
    enable = true;
  };

  services.userborn = {
    # enable = true;
    # TODO
    # Wait for https://github.com/nix-community/impermanence/pull/233 to be merged
  };

  environment.variables.NIX_REMOTE = "daemon";

  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      CacheDirectory = "nix";
    };
  };

}
