{
  lib,
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    nix-output-monitor

    lolcat
    cowsay

    nettools
    psmisc

    asciinema
    bat
    btop-cuda
    cyme
    dust
    fd
    fzf
    glow
    procs
    ripgrep
    tealdeer
    toolong

    just

    ffmpeg-full
    p7zip-rar
    unrar

    nvfetcher

  ];

  programs.nh = {
    enable = true;
    flake = "/home/lwb/Configurations/nix-config";
  };
  environment.shells = [
    "/etc/profiles/per-user/lwb/bin/fish"
    (lib.getExe pkgs.fish)
    "/etc/profiles/per-user/lwb/bin/nu"
    (lib.getExe pkgs.nushell)
    "/etc/profiles/per-user/lwb/bin/xonsh"
    (lib.getExe pkgs.xonsh)
  ];
}
