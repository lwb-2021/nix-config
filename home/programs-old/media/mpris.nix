{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    playerctl
  ];
  services.mpdris2 = {
    enable = true;
  };

  services.mpris-proxy.enable = true;
}
