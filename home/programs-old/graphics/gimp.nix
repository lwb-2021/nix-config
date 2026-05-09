{ pkgs, ... }:
{
  home.packages = with pkgs.noCuda; [
    gimp
  ];
}
