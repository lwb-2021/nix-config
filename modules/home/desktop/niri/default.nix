{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./binds.nix
    ./layout.nix
    ./rules.nix
  ];
  programs.niri = {
    enable = config.desktop.niri.enable;
    package = pkgs.niri;
    settings = {
      blur = {
        offset = 3;
        noise = 0.02;
        saturation = 1.5;
      };
      input = {
        touchpad = {
          natural-scroll = false;
        };
      };
      prefer-no-csd = true;
      spawn-at-startup = [
        { argv = [ "~/.config/autostart.sh" ]; }
      ];
      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite;
      };

      debug = {
        honor-xdg-activation-with-invalid-serial = true;
      };
    };
  };
  xdg.portal = lib.mkIf config.desktop.niri.enable {
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config = {
      niri = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Settings" = [ "gtk" "gnome" ];
      };
    };
  };

}
