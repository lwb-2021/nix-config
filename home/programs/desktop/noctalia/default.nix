{ lib, ... }:
{
  programs.noctalia-shell = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = import ./settings.nix;
  };

  wayland.locker.exec = "noctalia-shell ipc call lockScreen lock";

  systemd.user.services."noctalia-shell".Unit = {
    After = lib.mkForce [ "niri.service" ];
    Before = [ "graphical-session.target" ];
  };
}
