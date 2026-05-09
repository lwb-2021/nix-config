{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (wineWow64Packages.full.override {
      wineRelease = "staging";
      waylandSupport = true;
    })
    winetricks
  ];
  data.local.directories = [ ".wine" ];
}
