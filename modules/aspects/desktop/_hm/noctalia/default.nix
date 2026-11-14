{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop.noctalia;
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

}
