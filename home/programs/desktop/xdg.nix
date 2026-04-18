{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = with lib; {
    autostart = {
      prepareCommands = mkOption {
        type = types.listOf types.lines;
      };
      commands = mkOption {
        type = types.listOf types.lines;
      };
    };
  };

  config = {
    data = {
      persistence.directories = [
        "Music"
        "Documents"
        "Public"
      ];
      local.directories = [
        "Desktop"
        "Downloads"
        "Pictures"
        "Videos"

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
        pre = lib.concatStringsSep "\n" config.autostart.prepareCommands;
        post = lib.concatStringsSep "\n" config.autostart.commands;

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
    autostart = {
      prepareCommands = [
        "systemd-tmpfiles --create --user"
        "${lib.getExe pkgs.xrdb} ~/.Xresources"
      ];
      commands = lib.mkDefault [ ];
    };

  };

}
