{
  shell = {
    time_format = "{:%H:%M}";
    date_format = "%A, %x";

    panel = {
      transparency_mode = "solid";
      borders = true;
      shadow = true;
    };
  };

  theme = {
    mode = "dark";
    source = "builtin";
    builtin = "Catppuccin";
  };

  wallpaper.enabled = false;

  location.address = "Shanghai";

  bar.main = {
    position = "top";
    thickness = 34;
    background_opacity = 0.0;
    capsule = false;
    margin_ends = 180;
    margin_edge = 10;
    padding = 14;
    widget_spacing = 6;
    shadow = true;

    start = [
      "sysmon"
      "media"
      "active_window"
      "clock"
    ];
    center = [ ];
    end = [
      "tray"
      "notifications"
      "network"
      "bluetooth"
      "volume"
      "battery"
      "brightness"
      "control-center"
      "session"
    ];
  };

  widget = {
    sysmon = {
      stat = "disk_pct";
      path = "/nix";
    };
    battery = {
      show_label = true;
      warning_threshold = 30;
    };
    tray = {
      pinned = [ "*Obsidian" ];
    };
  };
}
