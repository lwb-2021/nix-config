{ config, ... }:
{
  programs.niri.settings = {
    hotkey-overlay = {
      skip-at-startup = true;
    };
    binds =
      with config.lib.niri.actions;
      let
        mod = "Mod";
        default-apps = config.desktop.default-applications;
      in
      {
        "${mod}+Shift+Slash".action = show-hotkey-overlay;

        "${mod}+T".action = spawn-sh "${default-apps.terminal}";
        "${mod}+R".action = spawn-sh "${default-apps.launcher}";
        "${mod}+E".action = spawn "thunar";
        "Print".action = spawn-sh "${default-apps.screenshot}";

        "${mod}+H".action = focus-column-left;
        "${mod}+J".action = focus-window-down;
        "${mod}+K".action = focus-window-up;
        "${mod}+L".action = focus-column-right;
        "${mod}+Shift+H".action = move-column-left;
        "${mod}+Shift+J".action = move-window-down;
        "${mod}+Shift+K".action = move-window-up;
        "${mod}+Shift+L".action = move-column-right;
        "${mod}+M".action = maximize-column;
        "${mod}+Minus".action = set-column-width "-10%";
        "${mod}+Equal".action = set-column-width "+10%";

        "${mod}+C".action = close-window;
        "${mod}+F".action = toggle-window-floating;
        "${mod}+Shift+M".action = toggle-windowed-fullscreen;

        "${mod}+Shift+Escape".action = quit;

        "${mod}+Tab" = {
          action = toggle-overview;
          repeat = false;
        };

        "${mod}+1".action = focus-workspace 1;
        "${mod}+2".action = focus-workspace 2;
        "${mod}+3".action = focus-workspace 3;
        "${mod}+4".action = focus-workspace 4;
        "${mod}+5".action = focus-workspace 5;
        "${mod}+6".action = focus-workspace 6;
        "${mod}+7".action = focus-workspace 7;
        "${mod}+8".action = focus-workspace 8;
        "${mod}+9".action = focus-workspace 9;

        "${mod}+Shift+1".action.move-column-to-workspace = [ 1 ];
        "${mod}+Shift+2".action.move-column-to-workspace = [ 2 ];
        "${mod}+Shift+3".action.move-column-to-workspace = [ 3 ];
        "${mod}+Shift+4".action.move-column-to-workspace = [ 4 ];
        "${mod}+Shift+5".action.move-column-to-workspace = [ 5 ];
        "${mod}+Shift+6".action.move-column-to-workspace = [ 6 ];
        "${mod}+Shift+7".action.move-column-to-workspace = [ 7 ];
        "${mod}+Shift+8".action.move-column-to-workspace = [ 8 ];
        "${mod}+Shift+9".action.move-column-to-workspace = [ 9 ];
      };
  };
}
