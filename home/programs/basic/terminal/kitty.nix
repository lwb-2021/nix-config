{ lib, pkgs, ... }:
let
  attach-to-tmux = pkgs.writeScript "attach-to-tmux.fish" ''
    #! /usr/bin/env fish
    set -l fzf_height (if set -q FZF_TMUX_HEIGHT; echo $FZF_TMUX_HEIGHT; else; echo "40%"; end)
    tmux ls -F '#{session_name}' | fzf --reverse --height $fzf_height --bind=enter:replace-query+print-query | read session
    set -l session_name (if test -n "$session"; echo $session; else; echo "default"; end)
    tmux attach -t $session_name; or tmux new -s $session_name
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

      shell = "${lib.getExe pkgs.fish} -i -c ${attach-to-tmux}";

      initial_window_width = "179c"; # $COLUMNS
      initial_window_height = "45c"; # $LINES

      confirm_os_window_close = "0";
    };
  };
  programs.tmux.terminal = "xterm-kitty";
  wayland.terminal.exec = "kitty -1";
}
