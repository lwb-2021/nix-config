{
  shell = {
    time_format = "{:%H:%M:%S}";
    date_format = "%A, %x";

    panel = {
      transparency_mode = "solid";
      borders = true;
      shadow = true;
    };
  };

  battery.warning_threshold = 20;
  theme = {
    mode = "dark";
    source = "builtin";
    builtin = "Catppuccin";
  };

  wallpaper.enabled = false;

  location.address = "Shanghai";

  bar.main = {
    position = "top";
    background_opacity = 0.0;
    capsule = false;
    shadow = true;

    margin_ends = 64;
    margin_edge = 10;
    widget_spacing = 10;
    padding = 14;
    thickness = 32;

    font_weight = 700;
    scale = 1.10;

    start = [
      "sysmon"
      "lock_keys"
      "privacy"
      "active_window"
    ];
    center = [
      "clock"
    ];
    end = [
      "tray"
      "spacer_2"
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
    clock.format = "{:%H:%M:%S}";
    sysmon = {
      stat = "ram_used";
      path = "/nix";
    };
    lock_keys = {
      display = "full";
      hide_when_off = true;
    };
    privacy.hide_inactive = true;
    active_window.display = "icon_only";

    tray = {
      detached_panel = true;
      drawer = true;
      match_adjacent_spacing = true;
      pinned = [ "Notes | Obsidian" ];
    };
    spacer_2 = {
      length = 24;
      type = "spacer";
    };
    notifications.hide_when_no_unread = true;
    network.show_label = false;
    volume.show_label = false;
    battery = {
      hide_when_plugged = true;
      show_label = false;
    };
    brightness.show_label = false;
  };

}
