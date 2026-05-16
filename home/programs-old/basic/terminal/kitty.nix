{ lib, pkgs, ... }:
let
  attach-to-tmux = pkgs.writeShellScript "attach-to-tmux.sh" ''
    tmux attach -t default || tmux new -s default
  '';
in
{
  programs.kitty = {
    enable = true;
    settings = {
      # Apperance
      transparent_background_colors = "#1e1e2f";
      disable_ligatures = "never";
      cursor_trail = "1";
      cursor_trail_decay = "0.1 0.4";
      pixel_scroll = "yes";

      shell = "nu";

      initial_window_width = "179c"; # $COLUMNS
      initial_window_height = "45c"; # $LINES

      confirm_os_window_close = "0";
    };
  };
  programs.tmux.terminal = "xterm-kitty";
  desktop.default-applications.terminal = "kitty -1 ${lib.getExe pkgs.bash} -i -c ${attach-to-tmux}";
}
