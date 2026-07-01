{
  lib,
  pkgs,
  nixpak-utils,
  ...
}:
let
  appId = "cn.feishu.Feishu";

  wrappedFeishu = pkgs.symlinkJoin {
    name = "feishu-wrapped";
    paths = [ pkgs.feishu ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/bytedance-feishu \
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
          package = wrappedFeishu;
          binPath = "bin/bytedance-feishu";
        };
        flatpak.appId = appId;

        imports = [
          ../nixpak-modules/base.nix
          ../nixpak-modules/gui-base.nix
          ../nixpak-modules/network.nix
        ];

        bubblewrap = {
          bind.rw = [
            sloth.xdgDownloadDir
          ];
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
      desktopName = "Feishu";
      genericName = "Feishu";
      comment = "Feishu is an all-in-one platform that integrates instant communication, calendar, video meeting, collaborative documents, workplace, and various features. Feishu aims to make your work more enjoyable while achieving better organizational results.";
      exec = "${exePath} %U";
      terminal = false;
      icon = "${pkgs.feishu}/share/icons/hicolor/256x256/apps/bytedance-feishu.png";
      startupNotify = true;
      type = "Application";
      categories = [
        "Office"
      ];
      mimeTypes = [
        "message/rfc822"
        "x-scheme-handler/feishu"
        "x-scheme-handler/feishu-open"
        "x-scheme-handler/lark"
        "x-scheme-handler/x-feishu"
      ];
      extraConfig = {
        "Name[zh_CN]" = "飞书";
        "GenericName[zh_CN]" = "飞书";
        X-Flatpak = appId;
      };
    })
  ];
}
