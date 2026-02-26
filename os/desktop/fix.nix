{ pkgs, ... }:
{
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ]; # fix fcitx5

  # Fix an issue of home-manager
  # https://github.com/nix-community/home-manager/issues/7166
  systemd.services.home-manager-lwb.serviceConfig = {
    RemainAfterExit = "yes";
  };

}
