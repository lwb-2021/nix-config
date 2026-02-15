{ pkgs, ... }:
{
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
}
