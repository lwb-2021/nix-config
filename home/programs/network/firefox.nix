{
  config,
  lib,
  pkgs,
  ...
}:
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

      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          # Theme
          catppuccin-mocha-mauve

          # Downloader
          aria2-integration
          single-file

          auto-tab-discard # Performance

          # UI
          darkreader
          sidebery

          # Connector
          browserpass
          zotero-connector
          web-clipper-obsidian

          pwas-for-firefox

          # Security
          # noscript # 会导致B站崩溃以及拖慢网页加载速度

          # Improvements
          ublock-origin
          redirector

          # Vim
          vimium-c

          tampermonkey # Script

        ];
        settings = {
          "{3c078156-979c-498b-8990-85f7987dd929}".settings = {
            settings = {
              navBarLayout = "hidden";

              previewTabs = true;
              previewTabsMode = "p";
              previewTabsPageModeFallback = "n";

              snapLimit = 3;
              snapLimitUnit = "snap";

              pinnedNoUnload = false;

              hideFoldedTabs = true;

              syncUseFirefox = false;
            };
          };
        };
      };
      settings = {
        # 基础设置
        "extensions.autoDisableScopes" = 0;
        "extensions.activeThemeID" = "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}";

        "font.language.group" = "zh-CN";
        "intl.locale.requested" = "zh-CN,en-US";

        # UI
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.uiCustomization.state" =
          ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["_3c078156-979c-498b-8990-85f7987dd929_-browser-action","back-button","forward-button","stop-reload-button","customizableui-special-spring1","vertical-spacer","urlbar-container","customizableui-special-spring2","downloads-button","fxa-toolbar-menu-button","unified-extensions-button","zotero_chnm_gmu_edu-browser-action"],"toolbar-menubar":["menubar-items"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks"]},"dirtyAreaCache":["unified-extensions-area","nav-bar","vertical-tabs","PersonalToolbar"],"currentVersion":22,"newElementCount":3}'';

        "media.autoplay.default" = 5;

        # 功能
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # 优化
        "nglayout.initialpaint.delay" = 0;
      };

      search.default = "bing";
      search.engines = {
        nix-packages = {
          name = "Nix Packages";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };

        nixos-wiki = {
          name = "NixOS Wiki";
          urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
          iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
          definedAliases = [ "@nw" ];
        };

        github = {
          name = "Github";
          urls = [
            {
              template = "https://github.com/search?q={searchTerms}";
            }
          ];
          iconMapObj."16" = "https://github.com/favicon.ico";
          definedAliases = [ "@github" ];
        };
      };

      userChrome = ''
        #TabsToolbar {
          display: none !important;
        }
        #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] #sidebar-header {
          visibility: collapse !important;
        }
        #sidebar-splitter {
          opacity: 0 !important;
          min-width: 1px !important;
          background-color: transparent !important;
          border: none !important;
        }
      '';
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
