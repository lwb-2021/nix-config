{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = with lib; {
    desktop = {
      enable = mkEnableOption { };
      niri = {
        enable = mkEnableOption { };
      };
      noctalia = {
        enable = mkEnableOption { };
      };

      # Universal Options

      autostart = {
        prepareCommands = mkOption {
          type = types.listOf types.lines;
        };
        commands = mkOption {
          type = types.listOf types.lines;
        };
      };
      default-applications = {
        terminal = mkOption {
          type = types.str;
        };
        screenshot = mkOption {
          type = types.str;
        };
        launcher = mkOption {
          type = types.str;
        };
        locker = mkOption {
          type = types.str;
        };
      };
    };
  };

  config =
    let
      removeHomePrefix = dir: (lib.removePrefix config.home.homeDirectory dir);
      removeHomePrefixFromAll = map removeHomePrefix;
    in
    lib.mkIf config.desktop.enable {
      data = {
        persistence.directories = removeHomePrefixFromAll (
          with config.xdg.userDirs;
          [
            music
            documents
            publicShare
          ]
        );
        local.directories =
          removeHomePrefixFromAll (
            with config.xdg.userDirs;
            [
              desktop
              download
              pictures
              videos
            ]
          )
          ++ [

            ".local/share/applications"
          ];
      };
      xdg = {
        autostart.enable = true;
        mime.enable = true;
        mimeApps = {
          enable = true;
          defaultApplications = {
            "inode/directory" = "thunar.desktop";
            "application/zip" = "xarchiver.desktop";
          };
        };
        portal = {
          enable = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal
            xdg-desktop-portal-gtk
          ];
        };
        userDirs = {
          enable = true;
          createDirectories = true;
        };
        terminal-exec = {
          enable = true;
          settings = {
            default = [ "kitty.desktop" ];
          };
        };
      };

      home.file =
        let
          shebang = "#!/usr/bin/env bash";
          pre = lib.concatStringsSep "\n" config.desktop.autostart.prepareCommands;
          post = lib.concatStringsSep "\n" config.desktop.autostart.commands;

        in
        {
          ".config/autostart.sh" = {
            executable = true;
            text = lib.concatStringsSep "\n" [
              shebang
              pre
              "sleep 1s"
              post
            ];
          };
        };
      desktop.autostart = {
        prepareCommands = lib.mkBefore [
          "systemd-tmpfiles --create --user"
          "${lib.getExe pkgs.xrdb} ~/.Xresources"
        ];
        commands = lib.mkDefault [ ];
      };
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
            ++ [ "-- ${config.desktop.default-applications.locker}" ]
          );
          Restart = "always";
        };
      };

    };

}
