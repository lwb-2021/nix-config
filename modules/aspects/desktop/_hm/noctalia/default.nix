{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop.noctalia;
  persist-state = name: ".local/state/noctalia/${name}";
in
{
  programs.noctalia = {
    enable = cfg.enable;
    settings = import ./settings.nix;

    # TODO: https://github.com/noctalia-dev/noctalia/pull/3980
    package = pkgs.noctalia.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [ ./0001-fix-qt-kcolorscheme-contrast.patch ];
    });
  };

  desktop.autostart.prepareCommands = lib.mkIf cfg.enable [ "noctalia &" ];

  desktop.default-applications.locker = lib.mkIf cfg.enable "noctalia msg session lock";

  data.local.directories = map persist-state [
    "clipboard"
    "community-palettes"
    "community-templates"
    "notification_history_assets"
    "plugins"
  ];
  data.local.files = map persist-state [
    "notification_history.enc"
    "screen_time.json"
    "state.toml"
  ];

  systemd.user.tmpfiles.rules = [
    "f ${config.xdg.stateHome}/noctalia/.setup-complete 0644 - -"
  ];
}
