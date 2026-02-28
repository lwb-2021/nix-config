{ lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = lib.getExe pkgs.fish;
  };
}
