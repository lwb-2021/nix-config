{
  lib,
  pkgs,
  nixpak-utils,
  ...
}:
let
  appId = "com.tencent.wemeet";

  wrappedWemeet = pkgs.symlinkJoin {
    name = "wemeet-wrapped";
    paths = [ pkgs.wemeet ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/wemeet \
        --prefix PATH : ${
          pkgs.lib.makeBinPath [
            pkgs.coreutils
            pkgs.flatpak-xdg-utils
          ]
        }
    '';
  };

  wrapped = nixpak-utils.mkNixPak {
    config =
      { sloth, ... }:
      {
        app = {
          package = wrappedWemeet;
          binPath = "bin/wemeet";
        };
        flatpak.appId = appId;

        imports = [
          ../nixpak-modules/base.nix
          ../nixpak-modules/gui-base.nix
          ../nixpak-modules/network.nix
        ];

        bubblewrap = {
          bind.ro = [
            "${pkgs.libxdamage}"
          ];
          bind.rw = [
            sloth.xdgDownloadDir
          ];
          bind.dev = [
            "/dev/snd" # Microphone
            "/dev/shm"
          ]
          ++ (map (id: "/dev/video${toString id}") (lib.lists.range 0 9)); # Camera
          sockets = {
            x11 = false;
            wayland = true;
            pipewire = true;
          };
        };
      };
  };
  exePath = lib.getExe wrapped.config.script;
in
pkgs.buildEnv {
  inherit (wrapped.config.script) name meta passthru;
  paths = [
    wrapped.config.script
    (pkgs.makeDesktopItem {
      name = appId;
      desktopName = "WemeetApp";
      exec = "${exePath} %u";
      terminal = false;
      icon = "${pkgs.wemeet}/share/icons/hicolor/scalable/apps/wemeet.svg";
      startupNotify = true;
      type = "Application";
      categories = [
        "Office"
      ];
      mimeTypes = [
        "x-scheme-handler/wemeet"
      ];
      extraConfig = {
        "Name[zh_CN]" = "腾讯会议";
        X-Flatpak = appId;
      };
    })
  ];
}
