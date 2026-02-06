{ config, pkgs, ... }:
{
  programs.mbsync = {
    enable = true;
  };
  services.imapnotify = {
    enable = true;
    package = pkgs.goimapnotify;
  };
  programs.neomutt = {
    enable = true;
    sidebar = {
      enable = true;
      shortPath = true;
    };
    settings = {
    };
  };
  programs.notmuch = {
    enable = true;
    new = {
      tags = [
        "unread"
        "inbox"
      ];
    };
  };
  programs.thunderbird = {
    enable = true;
    package = pkgs.noCuda.thunderbird;
    profiles = {
      ${config.home.username} = {
        isDefault = true;
      };
    };
  };
  accounts.email.maildirBasePath = "Mail";
  data.directories = [
    "Mail"
  ];
}
