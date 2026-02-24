{
  config,
  lib,
  pkgs,
  ...
}@params:
{
  /*
    home.packages = with pkgs; [
      (import ../../pkgs/wechat-pak.nix params)
      (import ../../pkgs/qq-pak.nix params)
      (import ../../pkgs/dingtalk-pak.nix params)
      (pkgs.makeDesktopItem {
        name = "com.tencent.wechat";
        desktopName = "WeChat";
        genericName = "wechat";
        categories = [ "Network" "Chat" ];
        keywords = [ "wechat" ];
        icon = "wechat";
        exec = "wechat %U";
        startupNotify = true;
        extraConfig = {
          "Name[zh_CN]" = "微信";
        };
      })
       (pkgs.makeDesktopItem {
        name = "com.tencent.qq";
        desktopName = "QQ";
        genericName = "qq";
        categories = [ "Network" "Chat" ];
        keywords = [ "qq" ];
        icon = "qq";
        exec = "qq %U";
        startupNotify = true;
      })

      wemeet

      obsidian

    ];
  */
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    remotes = [
      {
        name = "flathub";
        location = "https://mirrors.sjtu.edu.cn/flathub";
        gpg-import = "${pkgs.fetchurl {
          url = "https://mirror.sjtu.edu.cn/flathub/flathub.gpg";
          hash = "sha256-i9wgq8ThnAeWRgvrW/4OeqQThxaZnhnG8tvdeMxBrqo=";
        }}";
      }
    ];
    packages = [

      "com.github.tchx84.Flatseal"

      "com.tencent.WeChat"
      "com.qq.QQ"
      "com.tencent.wemeet"
      "com.dingtalk.DingTalk"
      "com.wps.Office"

    ];
    overrides = {
      "global" = {
        Context.filesystems = [
          "xdg-config/fontconfig:ro"
        ];
      };
      "com.wps.Office" = {
        Environment = {
          XMODIFIERS = "\"@im=fcitx\"";
          QT_IM_MODULE = "fcitx5";
          QT_FONT_DPI = "154";
        };
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/readest" = "readest.desktop";
  };
  home.sessionVariables = {
    GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
  };

  data =
    let
      appData = name: [ ".var/app/${name}/data" ];
      appConfig = name: [ ".var/app/${name}/config" ];
      appFile = name: filename: [ ".var/app/${name}/${filename}" ];
      appAll = name: [
        (appConfig name)
        (appData name)
      ];
    in
    {
      persistence.directories = lib.flatten [
        (appFile "com.tencent.WeChat" "xwechat_files")
        (appFile "com.tencent.WeChat" ".xwechat")

        (appConfig "com.qq.QQ")

        (appConfig "com.wps.Office")
        (appAll "com.dingtalk.DingTalk")
      ];
      local.directories = lib.flatten [
        ".local/share/flatpak"
        (appData "com.tencent.wemeet")
      ];
    };

}
