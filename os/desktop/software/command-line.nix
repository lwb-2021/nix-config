{
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    nix-output-monitor

    lolcat
    carbon-now-cli
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

    qwen-code
  ];

  programs.nh = {
    enable = true;
    flake = "/home/lwb/Configurations/nix-config";
  };
}
