{ pkgs, ... }:
{
  sops.age.keyFile = "/data/persistence/keys.txt";
  fileSystems."/data".neededForBoot = true;

  sops.defaultSopsFile = ./files/os.yaml;

  environment.systemPackages = [ pkgs.sops ];
  sops.secrets = {
    "easytier/default/secret-env" = { };
  };
}
