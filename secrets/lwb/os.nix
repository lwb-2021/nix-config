{ pkgs, ... }:
{
  sops.age.keyFile = "/data/persistence/keys.txt";
  sops.defaultSopsFile = ./files/os.yaml;
  # Or
  # fileSystems."/etc/ssh".neededForBoot = true;

  environment.systemPackages = [ pkgs.sops ];
  sops.secrets = {
    "easytier/default/secret-env" = { };
    "syncthing/passwords/backup" = { };
  };
}
