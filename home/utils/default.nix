{ lib, pkgs, ... }:
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
          onNotifyPost = lib.concatStringsSep " && " (
            [
              "${lib.getExe pkgs.notmuch} new"
            ]
            ++ [
              ("${lib.getExe pkgs.libnotify} '请查收邮件'")
            ]
          );
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
