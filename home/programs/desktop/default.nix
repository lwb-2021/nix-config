{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./xdg.nix
    ./vars.nix
  ];

  options = with lib; {
    wayland.launcher.exec = mkOption {
      type = types.str;
    };
    wayland.screenshot.exec = mkOption {
      type = types.str;
    };
    wayland.terminal.exec = mkOption {
      type = types.str;
    };
    wayland.locker.exec = mkOption {
      type = types.str;
    };
  };
  config = {
    systemd.user.services."xss-lock" = {
      Unit = {
        Description = "xss-lock, session locker service";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = lib.concatStringsSep " " (
          [
            "${pkgs.xss-lock}/bin/xss-lock"
            "-s \${XDG_SESSION_ID}"
          ]
          ++ [ "-- ${config.wayland.locker.exec}" ]
        );
        Restart = "always";
      };
    };
  };

}
