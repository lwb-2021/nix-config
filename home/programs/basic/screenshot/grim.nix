{ pkgs, ... }:
{
  home.packages = with pkgs; [
    slurp
    grim
    wl-clipboard-rs
  ];

  programs.satty = {
    enable = true;
    settings = {
      general = {
        fullscreen = true;
        copy-command = "wl-copy";
      };
    };
  };

  wayland.screenshot.exec = "grim -g \"$(slurp -o -r -c '#ff0000ff')\" -t ppm - | satty --filename - --fullscreen --output-filename $XDG_PICTURES_DIR/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png";
}
