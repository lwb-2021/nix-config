{ lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = lib.getExe pkgs.fish;
    plugins = with pkgs.tmuxPlugins; [
      tmux-which-key
    ];
  };
}
