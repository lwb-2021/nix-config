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
  programs.firefoxpwa = {
    enable = true;
    package = pkgs.noCuda.firefoxpwa;
    profiles = {
      "01KH2V889B2VY1C7ETBA791FEE" = {
        sites."01KH2V889B667183MWV0K1QHCT" = {
          name = "Cinny";
          url = "https://app.cinny.in";
          manifestUrl = "https://app.cinny.in/manifest.json";
          desktopEntry = {
            enable = true;
            icon = pkgs.fetchurl {
              url = "https://app.cinny.in/favicon.ico";
              hash = "sha256-eU8N9PPAsYr5JHUlgqkm8AXrrTSQl7G2pU/nBA2Zb60=";
            };
          };
        };
      };
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
