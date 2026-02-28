{ lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    newSession = true;
    shell = lib.getExe pkgs.fish;
  };
}
