{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.theming.qt.enable {
    home.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qtct";
      QT_QPA_PLATFORM = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
  };
}
