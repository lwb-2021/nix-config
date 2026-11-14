{
  lib,
  ...
}:
{
  flake.aspects.theming.hm =
    { config, pkgs, ... }:
    let
      cfg = config.theming.qt;

      qt5ctColors = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
      qt6ctColors = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";

      keepassxcQss = pkgs.writeText "keepassxc.qss" ''
        DatabaseOpenWidget #centralStack,
        DatabaseOpenWidget #mainPage,
        DatabaseOpenWidget #enterPasswordComponent,
        DatabaseOpenWidget #publicSummaryLabel {
            background: palette(window) !important;
            border: none;
            border-radius: 8px;
        }
      '';

      qt-settings = colors: {
        Appearance = {
          style = "Klassy";

          icon_theme = config.theming.icons.name;
          custom_palette = true;
          color_scheme_path = colors;
        };
        Interface.stylesheets = [ "${keepassxcQss}" ];
      };
    in
    {
      config = lib.mkIf cfg.enable {
        qt = {
          enable = true;
          platformTheme.name = "qtct";
          style = {
            name = "klassy";
            package = pkgs.klassy;
          };

          qt5ctSettings = qt-settings qt5ctColors;
          qt6ctSettings = qt-settings qt6ctColors;
        };

        home.sessionVariables = {
          QT_QPA_PLATFORM = "wayland";
          QT_AUTO_SCREEN_SCALE_FACTOR = "1";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        };
      };
    };
}
