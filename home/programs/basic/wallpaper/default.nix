{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waypaper
  ];
  xdg.configFile."waypaper/config.ini".source = ./waypaper.ini;
  desktop.autostart.commands = [ "waypaper --restore" ];
}
