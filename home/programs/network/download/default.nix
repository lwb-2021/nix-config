{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    motrix-next
  ];
  sops.templates."motrix-next-config.json".content = builtins.toJSON (

    (builtins.fromJSON (builtins.readFile ./motrix-next-config.json))
    // {
      preferences = {
        autoCheckUpdate = false;

        colorScheme = "aurora";

        autoHideWindow = true;
        lightweightMode = true;
        traySpeedometer = false;

        continue = true;
        dir = config.xdg.userDirs.download;
        rpcListenPort = 16800;
        rpcSecret = config.sops.placeholder."aria2/rpc-secret";

        autoSyncTracker = true;
        seedRatio = 2;

        protocols = {
          magnet = true;
          motrixnext = true;
          thunder = true;
        };
      };
    }
  );
  home.tmpfiles.dataFile."com.motrix.next/config.json".source =
    config.sops.templates."motrix-next-config.json".path;

  data.persistence.files = [
    {
      file = ".local/share/com.motrix.next/download.session";
      # method = "symlink";
    }
  ];
  xdg.mimeApps.defaultApplications =
    let
      motrix-next-handler = ".motrix-next-wrapped-handler.desktop";
    in
    {
      "x-scheme-handler/magnet" = motrix-next-handler;
      "x-scheme-handler/thunder" = motrix-next-handler;
      "x-scheme-handler/motrixnext" = motrix-next-handler;
    };
  autostart.commands = [ "motrix-next --autostart & " ];
}
