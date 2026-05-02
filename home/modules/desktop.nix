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
      autostart = {
        prepareCommands = mkOption {
          type = types.listOf types.lines;
        };
        commands = mkOption {
          type = types.listOf types.lines;
        };
      };
    };
  };

  config =
    let
      removeHomePrefix = dir: (lib.removePrefix config.home.homeDirectory dir);
      removeHomePrefixFromAll = builtins.map removeHomePrefix;
    in
    {
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
        prepareCommands = [
          "systemd-tmpfiles --create --user"
          "${lib.getExe pkgs.xrdb} ~/.Xresources"
        ];
        commands = lib.mkDefault [ ];
      };

    };

}
