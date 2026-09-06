{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.theming.cursor.enable {
    home.pointerCursor = {
      enable = true;
      name = config.theming.cursor.name;
      package = config.theming.cursor.package;
      x11 = {
        enable = true;
        size = config.theming.cursor.size;
      };
      gtk.enable = true;
    };
  };
}
