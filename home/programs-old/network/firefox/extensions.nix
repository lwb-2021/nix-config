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

    # Connector
    browserpass
    zotero-connector
    web-clipper-obsidian

    # Security
    # noscript # 会导致B站崩溃以及拖慢网页加载速度

    # Improvements
    ublock-origin
    redirector

    # Vim
    vimium-c
    newtab-adapter

    tampermonkey # Script

  ];
  settings = { };
}
