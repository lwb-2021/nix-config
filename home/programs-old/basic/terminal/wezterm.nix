{ ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
  desktop.autostart.commands = [ "wezterm-mux-server --daemonize" ];
  wayland.terminal.exec = "wezterm";
}
