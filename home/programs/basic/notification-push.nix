{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.kunifiedpush
  ];
  # xdg.configFile."KDE/kunifiedpush-distributor.conf" = {};
}
