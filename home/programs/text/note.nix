{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian
  ];
  xdg.autostart.entries = [
    "${pkgs.obsidian}/share/applications/obsidian.desktop"
  ];
}
