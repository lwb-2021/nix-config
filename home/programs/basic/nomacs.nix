{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nomacs
  ];
  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = "org.nomacs.ImageLounge.desktop";
    "image/png" = "org.nomacs.ImageLounge.desktop";
    "image/bmp" = "org.nomacs.ImageLounge.desktop";
  };

}
