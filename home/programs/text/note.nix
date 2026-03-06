{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;
  };

  data.sync.folders = [
    "Documents/Obsidian"
  ];
  autostart.commands = [ "sleep 2s && obsidian" ];
  # "${pkgs.obsidian}/share/applications/obsidian.desktop"
}
