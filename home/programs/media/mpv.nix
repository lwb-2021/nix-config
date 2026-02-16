{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      evafast
      modernz
    ];
  };
  xdg.mimeApps.defaultApplications = {
    "audio/mpeg" = "mpv.desktop";
    "audio/wav" = "mpv.desktop";
    "video/mpeg" = "mpv.desktop";
    "video/mp4" = "mpv.desktop";
    "x-scheme-handler/mpv" = "mpv.desktop";
  };
}
