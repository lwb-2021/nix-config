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
  desktop.autostart.commands = [ "obsidian & " ];
}
