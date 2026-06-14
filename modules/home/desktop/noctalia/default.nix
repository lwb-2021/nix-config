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
    # package = pkgs.noctalia-shell;
    settings = import ./settings.nix;
  };

  desktop.autostart.prepareCommands = lib.mkIf cfg.enable [ "noctalia &" ];

  desktop.default-applications.locker = lib.mkIf cfg.enable "noctalia msg session lock";

}
