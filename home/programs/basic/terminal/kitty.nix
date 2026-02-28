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
      disable_ligatures = "never";
      shell = "${lib.getExe pkgs.fish} -c ${attach-to-tmux}";
    };
  };
  programs.tmux.terminal = "xterm-kitty";
  wayland.terminal.exec = "kitty -1";
}
