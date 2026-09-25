{
  config,
  lib,
  sloth,
  ...
}:
{

  config = {
    dbus.policies = {
      "${config.flatpak.appId}" = "own";
      "${config.flatpak.appId}.*" = "own";

      "org.a11y.Bus" = "talk";

      "org.freedesktop.portal.*" = "talk"; # TODO

      "org.freedesktop.DBus" = "talk";
      # "org.gtk.vfs.*" = "talk";
      # "org.gtk.vfs" = "talk";
      "ca.desrt.dconf" = "talk";
      "org.freedesktop.appearance" = "talk";
      "org.freedesktop.appearance.*" = "talk";

    };

    bubblewrap = {
      network = lib.mkDefault false;

      sockets = {
        pulse = true;
      };
      bind.rw = [
        # use mkPersistSloth
        # [
        #   (sloth.mkdir sloth.appDir)
        #   sloth.homeDir
        # ]

        # Simluate machine-id
        [
          (sloth.concat' sloth.appDir "/machine-id")
          "/etc/machine-id"
        ]

        [
          (sloth.mkdir sloth.appCacheDir)
          sloth.xdgCacheHome
        ]
        [
          (sloth.mkdir sloth.appConfigDir)
          sloth.xdgConfigHome
        ]
        [
          (sloth.mkdir sloth.appDataDir)
          sloth.xdgDataHome
        ]
      ];
      bind.ro = [

        "/etc/localtime"
        "/etc/zoneinfo"
      ];
      tmpfs = [ "/tmp" ];

    };
  };
}
