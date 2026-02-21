{ lib, pkgs, ... }@params:
let
  utils = import ./utils params;
in
{
  home.username = "lwb";
  home.homeDirectory = "/home/lwb";
  home.stateVersion = "25.05";
  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 153.6;
  };
  programs.git.settings.user = {
    name = "lwb";
    email = "lwb-2021@qq.com";
  };
  accounts.email.accounts = {
    "QQ" = (
      utils.mail.configureClients "QQ" {
        address = "lwb-2021@qq.com";
        realName = "lwb";
        passwordCommand = "${lib.getExe pkgs.pass} Mail/QQ/imap";
        primary = true;
      }
      // utils.mail.preset.qq
    );
  };
  imports = [
    ./config/i18n.nix
    ./config/thunar.nix

    ./data

    ./programs/media/lyrics.nix
    ./programs/media/mpd.nix
    ./programs/media/mpris.nix
    ./programs/media/mpv.nix
    ./programs/media/ncmpcpp.nix

    ./programs/apps.nix

    ./programs/compatibility/wine.nix

    ./programs/creation/gimp.nix
    ./programs/creation/drawio.nix

    ./programs/daily/office.nix
    ./programs/daily/note.nix
    ./programs/daily/pandoc.nix
    ./programs/daily/ebook.nix

    ./programs/desktop
    ./programs/desktop/niri

    ./programs/desktop/noctalia

    ./programs/desktop/apps/notification-push.nix

    ./programs/desktop/apps/nomacs.nix

    ./programs/desktop/apps/clipboard
    ./programs/desktop/apps/launcher/vicinae.nix
    ./programs/desktop/apps/screenshot/grim.nix
    ./programs/desktop/apps/terminal/wezterm.nix
    ./programs/desktop/apps/wallpaper
    ./programs/desktop/apps/wallpaper/swww.nix

    ./programs/desktop/rime.nix

    ./programs/development
    ./programs/development/version-control.nix
    ./programs/development/editors/code.nix
    ./programs/development/editors/neovim.nix
    ./programs/development/editors/idea.nix

    ./programs/development/languages/java.nix
    ./programs/development/languages/python.nix

    ./programs/game/lutris.nix
    ./programs/game/minecraft.nix

    ./programs/network/aria2
    ./programs/network/chat.nix
    ./programs/network/firefox
    ./programs/network/kdeconnect.nix
    ./programs/network/syncthing.nix
    ./programs/network/mail.nix

    ./programs/research/zotero.nix

    ./programs/security

    ./programs/shell
    ./programs/shell/atuin.nix
    ./programs/shell/pay-respect.nix
    ./programs/shell/starship.nix

    ./programs/shell/cli-tools/bat.nix
    ./programs/shell/cli-tools/eza.nix
    ./programs/shell/cli-tools/fastfetch.nix
    ./programs/shell/cli-tools/jq.nix
    ./programs/shell/cli-tools/navi.nix
    ./programs/shell/cli-tools/ripgrep.nix
    ./programs/shell/cli-tools/yazi.nix
    ./programs/shell/cli-tools/zoxide.nix

    ./programs/study/anki.nix
  ];

}
