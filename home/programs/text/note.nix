{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;
  };

  data.sync.folders = [
    "Documents/Obsidian"
  ];

  xdg.autostart.entries = [
    "${pkgs.obsidian}/share/applications/obsidian.desktop"
  ];
}
