{ ... }:
{
  programs.atuin = {
    enable = true;
    forceOverwriteSettings = true;
    daemon = {
      enable = true;
    };
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      history_filter = [
        "^z\\s+"
        ".*/nix/store/.+"
        "^python"
        "^ydict"
      ];
      store_failed = false;
      secrets_filter = true;

      sync = {
        records = true;
      };
    };
  };
  data.local.directories = [ ".local/share/atuin" ];
}
