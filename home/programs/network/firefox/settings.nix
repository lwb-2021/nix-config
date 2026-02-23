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
        "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
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
        "zotero_chnm_gmu_edu-browser-action"
      ];
      "toolbar-menubar" = [ "menubar-items" ];
      "vertical-tabs" = [ ];
      "PersonalToolbar" = [ "personal-bookmarks" ];
    };
  };

  "media.autoplay.default" = 5;

  # 功能
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

  # 优化
  "nglayout.initialpaint.delay" = 0;
}
