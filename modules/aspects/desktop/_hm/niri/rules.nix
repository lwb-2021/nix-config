{ ... }:
{
  programs.niri.settings.window-rules = [
    {
      geometry-corner-radius =
        let
          radius = 12.0;
        in
        {
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
        };
      clip-to-geometry = true;

      background-effect = {
        blur = true;
        xray = true;
      };
    }
    {
      matches = [ { is-floating = true; } ];
      background-effect = {
        xray = false;
      };
    }

    {
      matches = [ { app-id = "file-chooser"; } ];
      open-floating = true;
      open-focused = true;
      default-column-width.proportion = 0.6;
      default-window-height.proportion = 0.5;
    }
    {
      matches = [ { app-id = "io.github.waylyrics.Waylyrics"; } ];
      open-floating = true;
      focus-ring.enable = false;
      default-floating-position = {
        relative-to = "bottom";
        x = 0;
        y = 120;
      };
      default-column-width.proportion = 0.4;
      default-window-height.fixed = 120;
      background-effect.blur = false;

    }
  ];
}
