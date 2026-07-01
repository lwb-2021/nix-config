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
    }
    {
      matches = [ { app-id = "file-chooser"; } ];
      open-floating = true;
      open-focused = true;
      default-column-width.proportion = 0.6;
      default-window-height.proportion = 0.5;
    }
  ];
}
