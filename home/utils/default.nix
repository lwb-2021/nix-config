{
  config,
  lib,
  pkgs,
  ...
}:
{
  mail = {
    configureClients =
      name: account:
      account
      // {
        userName = lib.mkDefault account.address;
        imapnotify = {
          enable = lib.mkDefault true;
          onNotify = "mbsync ${name}";
          onNotifyPost = {
            mail = lib.mkIf config.programs.noctalia-shell.enable "${lib.getExe pkgs.notmuch} new && ${lib.getExe pkgs.libnotify} '请查收邮件'";
          };
          boxes = [ "INBOX" ];
        };
        mbsync = {
          enable = lib.mkDefault true;
          create = "maildir";
        };
        neomutt = {
          enable = lib.mkDefault true;
          mailboxType = "maildir";
        };
        notmuch = {
          enable = lib.mkDefault true;
          neomutt = {
            enable = lib.mkDefault true;
            virtualMailboxes = [
              {
                name = "Unread";
                query = "tag:unread";
              }
            ];
          };
        };
        thunderbird = {
          enable = lib.mkDefault true;
          profiles = [ "${config.home.username}" ];
        };
      };
    preset = {
      qq = {
        imap = {
          host = "imap.qq.com";
          port = 993;
        };
        smtp = {
          tls.enable = true;
          host = "smtp.qq.com";
          port = 465; # 587
        };
      };

    };
  };
}
