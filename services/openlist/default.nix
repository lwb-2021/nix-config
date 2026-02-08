{ lib, pkgs, ... }:
{
  imports = [
  ];
  config = {
    systemd.services.openlist = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      requires = [ "network-online.target" ];
      script = "${lib.getExe pkgs.openlist} --data /var/lib/openlist server";
      serviceConfig = {
        User = "openlist";
        Group = "openlist";
      };
    };
    users.users.openlist = {
      name = "openlist";
      group = "openlist";
      home = "/var/lib/openlist";
      createHome = true;
      isSystemUser = true;

    };
    users.groups.openlist = {
      name = "openlist";

    };
  };
}
