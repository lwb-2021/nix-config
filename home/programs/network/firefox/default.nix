{
  config,
  lib,
  pkgs,
  ...
}@params:
{
  data = {
    local.directories = [
      ".cache/mozilla"
      ".mozilla/firefox" # Mozilla Sync, do not need backup
    ];
  };
  home.file.".mozilla/firefox/default/search.json.mozlz4".force = lib.mkForce true;
  programs.firefox = {
    enable = true;
    package = pkgs.noCuda.firefox;
    languagePacks = [
      "zh-CN"
      "en-US"
    ];

    nativeMessagingHosts = with pkgs.noCuda; [
      firefoxpwa
    ];

    policies = {
      ExtensionSettings = {
        "{e2488817-3d73-4013-850d-b66c5e42d505}" = {
          enabled = true;
          initialize = true;
          menu = true;
          ua = true;
          windowLoc = true;
          autoSet = true;
          path = config.xdg.userDirs.download;
          protocol = "ws";
          host = "127.0.0.1";
          port = "6800";
          interf = "jsonrpc";
          token = "";
          sound = "3";
        };
      };
    };
    profiles.default = {
      isDefault = true;

      extensions = import ./extensions.nix params;
      settings = import ./settings.nix;
      search = import ./search.nix params;

      userChrome = builtins.readFile ./userChrome.css;
    };
  };
  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
    "application/pdf" = "firefox.desktop";
  };
}
