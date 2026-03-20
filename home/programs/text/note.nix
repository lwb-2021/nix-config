{ config, ... }:
{
  programs.obsidian = {
    enable = true;
    defaultSettings = {
    };
    vaults."${config.home.homeDirectory}/Documents/Notes" = {
      enable = false;
    };
  };

  data.sync.folders = [
    "Documents/Notes"
  ];
  autostart.commands = [ "sleep 2s && obsidian & " ];
  # "${pkgs.obsidian}/share/applications/obsidian.desktop"
}
