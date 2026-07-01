{
  config,
  lib,
  pkgs,
  sloth,
  ...
}@params:
{
  config = {
    dbus.policies = {
      "org.freedesktop.FileManager1" = "talk";
      "org.freedesktop.Notifications" = "talk";
      "org.kde.StatusNotifierWatcher" = "talk";
      "org.gnome.Shell.Screencast" = "talk";
    };

    gpu = {
      enable = lib.mkDefault true;
      provider = "bundle";
      bundlePackage = lib.mkDefault pkgs.mesa;
    };

    fonts = {
      enable = true;
      fonts =
        params.homeConfig.fonts.packages or (with pkgs; [
          source-han-sans

          nerd-fonts.jetbrains-mono

          noto-fonts-color-emoji
        ]);
    };
    locale.enable = true;

    bubblewrap = {

      sockets = {
        wayland = true;
      };
      bind.rw = [
        (sloth.concat' sloth.xdgCacheHome "/fontconfig")
        (sloth.concat' sloth.xdgCacheHome "/mesa_shader_cache")

        (sloth.concat' sloth.runtimeDir "/at-spi/bus")
        (sloth.concat' sloth.runtimeDir "/gvfsd")
        (sloth.concat' sloth.runtimeDir "/dconf")

        (sloth.concat' sloth.runtimeDir "/doc") # For document portal
      ];
      bind.ro = [

        (sloth.concat' sloth.xdgConfigHome "/gtk-2.0")
        (sloth.concat' sloth.xdgConfigHome "/gtk-3.0")
        (sloth.concat' sloth.xdgConfigHome "/gtk-4.0")
        (sloth.concat' sloth.xdgConfigHome "/fontconfig")
        (sloth.concat' sloth.xdgConfigHome "/dconf")

      ];

      env =
        let
          icons = params.homeConfig.stylix.icons.package or pkgs.adwaita-icon-theme;
          cursor = params.homeConfig.stylix.cursor.package or pkgs.adw-gtk3;
          # Stylix compatibility
        in
        {
          XDG_DATA_DIRS = lib.makeSearchPath "share" [
            icons
            cursor
            pkgs.shared-mime-info
          ];
          XCURSOR_PATH = lib.concatStringsSep ":" [
            "${cursor}/share/pixmaps"
            "${icons}/share/icons"
          ];
        };
    };
  };
}
