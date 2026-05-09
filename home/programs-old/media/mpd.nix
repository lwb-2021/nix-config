{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.mpd = {
    enable = true;
    extraConfig = ''
      audio_output {
          type "pipewire"
          name "PipeWire Output"
      }

      audio_output {
          type                    "fifo"
          name                    "FIFO"
          path                    "/tmp/mpd.fifo"
          format                  "44100:16:2"
      }
    '';
  };
  home.packages = with pkgs; [
    mpc
  ];
}
