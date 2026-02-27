{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waypaper
  ];
  xdg.configFile."waypaper/config.ini".source = ./waypaper.ini;
  autostart.commands = [ "waypaper --restore" ];
}
