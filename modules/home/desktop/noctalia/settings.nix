{
  general = {
    showHibernateOnLockScreen = true;
  };
  colorSchemes.predefinedScheme = "Catppuccin";

  dock.enabled = false;
  wallpaper.enabled = false;

  location = {
    name = "Shanghai";
  };

  ui = {
    panelBackgroundOpacity = 0.0;
  };

  bar = {
    showCapsule = false;
    capsuleOpacity = 0.0;
    floating = true;

    "widgets" = {
      "left" = [
        {
          id = "Clock";
        }
        {
          id = "SystemMonitor";
          "diskPath" = "/nix";
        }
        {

          id = "MediaMini";
        }
        {

          id = "ActiveWindow";

        }
      ];
      center = [ ];
      right = [
        {
          id = "Tray";
          blacklist = [ ];
          pinned = [
            "*Obsidian"
          ];
        }
        {
          id = "NotificationHistory";
        }
        {
          id = "Network";
        }
        {
          id = "Bluetooth";
        }
        {
          id = "Volume";
        }
        {
          id = "Battery";
          displayMode = "alwaysShow";
          showPowerProfiles = true;
          warningThreshold = 30;
        }

        {
          id = "Brightness";
        }
        {
          id = "ControlCenter";
          useDistroLogo = true;
          enableColorization = true;
        }
      ];
    };
  };
  controlCenter = {
    diskPath = "/nix";
  };

}
