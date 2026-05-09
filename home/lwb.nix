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
  desktop.enable = true;

  home.packages = with pkgs; [
    drawy
  ];

  imports = [
    ./modules

    ./config/i18n.nix
    ./config/thunar.nix

    ./data

    # DE

    ./programs-old/desktop
    ./programs-old/desktop/niri
    ./programs-old/desktop/noctalia

    ./programs-old/basic

    ./programs-old/desktop/rime.nix

    ./programs-old/apps.nix

    # Development
    ./programs-old/development
    ./programs-old/development/version-control.nix
    ./programs-old/development/editors/code.nix
    ./programs-old/development/editors/neovim.nix
    ./programs-old/development/editors/idea.nix

    ./programs-old/development/languages/java.nix
    ./programs-old/development/languages/python.nix

    #

    ./programs-old/media/lyrics.nix
    ./programs-old/media/mpd.nix
    ./programs-old/media/mpris.nix
    ./programs-old/media/mpv.nix
    ./programs-old/media/ncmpcpp.nix

    ./programs-old/compatibility/wine.nix

    ./programs-old/graphics/gimp.nix
    ./programs-old/graphics/drawio.nix

    ./programs-old/text/note.nix
    ./programs-old/text/pandoc.nix
    ./programs-old/text/ebook.nix
    ./programs-old/text/zettlr.nix
    ./programs-old/text/zotero.nix

    ./programs-old/game/lutris.nix
    ./programs-old/game/minecraft.nix

    ./programs-old/network/download
    ./programs-old/network/chat.nix
    ./programs-old/network/firefox
    ./programs-old/network/kdeconnect.nix
    ./programs-old/network/mail.nix

    ./programs-old/security

    ./programs-old/shell
    ./programs-old/shell/tmux
    ./programs-old/shell/atuin.nix
    ./programs-old/shell/pay-respect.nix
    ./programs-old/shell/starship.nix

    ./programs-old/shell/cli-tools/bat.nix
    ./programs-old/shell/cli-tools/eza.nix
    ./programs-old/shell/cli-tools/fastfetch.nix
    ./programs-old/shell/cli-tools/jq.nix
    ./programs-old/shell/cli-tools/navi.nix
    ./programs-old/shell/cli-tools/ripgrep.nix
    ./programs-old/shell/cli-tools/taskwarrior.nix
    ./programs-old/shell/cli-tools/yazi.nix
    ./programs-old/shell/cli-tools/zoxide.nix

    ./programs-old/shell/cli-tools/others.nix

    ./programs-old/education/anki.nix

    ./programs-old/cybersecurity.nix
  ];

}
