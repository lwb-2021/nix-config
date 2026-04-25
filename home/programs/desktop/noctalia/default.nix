{ lib, ... }:
{
  programs.noctalia-shell = {
    enable = true;
    settings = import ./settings.nix;
  };

  autostart.prepareCommands = [ "noctalia-shell &" ];

  wayland.locker.exec = "noctalia-shell ipc call lockScreen lock";

}
