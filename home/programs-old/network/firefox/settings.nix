{
  # 基础设置
  "extensions.autoDisableScopes" = 0;
  "extensions.activeThemeID" = "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}";

  "font.language.group" = "zh-CN";
  "intl.locale.requested" = "zh-CN,en-US";

  # UI
  "browser.toolbars.bookmarks.visibility" = "always";
  "browser.uiCustomization.state" = builtins.toJSON {
    "placements" = {
      "widget-overflow-fixed-list" = [ ];
      "nav-bar" = [
        "back-button"
        "forward-button"
        "stop-reload-button"
        "customizableui-special-spring1"
        "vertical-spacer"
        "urlbar-container"
        "customizableui-special-spring2"
        "downloads-button"
        "fxa-toolbar-menu-button"
        "unified-extensions-button"
        "clipper_obsidian_md-browser-action"
        # "zotero_chnm_gmu_edu-browser-action"
      ];
      "toolbar-menubar" = [ "menubar-items" ];
      "vertical-tabs" = [ ];
      "PersonalToolbar" = [ "personal-bookmarks" ];
    };
  };

  "sidebar.verticalTabs" = true;
  "sidebar.visibility" = "expand-on-hover";
  "Sidebar.main.tools" = builtins.toJSON [
    "{531906d3-e22f-4a6c-a102-8057b88a1a63}"
    "history"
    "bookmarks"
    "syncedtabs"
  ];

  "extensions.webextensions.ExtensionStorageIDB.enabled" = false;
  "browser.nova.enabled" = true;

  "media.autoplay.default" = 5;

  # 功能
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

  # 优化
  "nglayout.initialpaint.delay" = 0;
}
