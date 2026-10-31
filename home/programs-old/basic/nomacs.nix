{
  pkgs,
  ...
}:
{
  home.packages = with pkgs.noCuda; [
    nomacs
  ];
  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = "org.nomacs.ImageLounge.desktop";
    "image/png" = "org.nomacs.ImageLounge.desktop";
    "image/bmp" = "org.nomacs.ImageLounge.desktop";
  };

}
