{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.aria2 = {
    enable = true;
    systemd.enable = true;
    package = pkgs.aria2.overrideAttrs (prev: {
      patches = (prev.patches or [ ]) ++ [ ./aria2-fast.patch ];
    });
    settings = {
      auto-file-renaming = true;
      continue = true;
      dir = "${config.xdg.userDirs.download}";
      always-resume = false;

      disk-cache = "64M";
      file-allocation = "none";

      http-accept-gzip = true;
      split = 64;
      max-connection-per-server = 128;
      min-split-size = "1M";

      bt-detach-seed-only = true;
      bt-force-encryption = true;
      bt-max-peers = 128;
      bt-tracker = builtins.readFile "${inputs.bt-tracker-list}/best_aria2.txt";
      dht-entry-point = "dht.transmissionbt.com:6881";
      enable-dht = true;
      enable-peer-exchange = true;
      seed-ratio = 2.0;
    };
  };
  home.packages = with pkgs; [ ariang ];
}
