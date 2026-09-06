{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.theming.gtk.enable {
    gtk = {
      enable = true;
      theme = {
        name = config.theming.gtk.theme.name;
        package = config.theming.gtk.theme.package;
      };
      iconTheme = {
        name = config.theming.icons.name;
        package = config.theming.icons.package;
      };
      font = {
        name = config.theming.gtk.font.name;
        size = config.theming.gtk.font.size;
      };
    };
    home.packages = with pkgs; [
      gnome-themes-extra
    ];
  };
}
