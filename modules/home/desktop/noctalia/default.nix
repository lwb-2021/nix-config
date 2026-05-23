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
  programs.noctalia-shell = {
    enable = cfg.enable;
    package = pkgs.noctalia-shell;
    settings = import ./settings.nix;
  };

  desktop.autostart.prepareCommands = lib.mkIf cfg.enable [ "noctalia-shell &" ];

  desktop.default-applications.locker = lib.mkIf cfg.enable "noctalia-shell ipc call lockScreen lock";

}
