{ pkgs, ... }:
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
  home.file.".mailcap".text = ''
    text/html; ${pkgs.w3m}/bin/w3m -I %{charset} -T text/html; copiousoutput;
  '';
  accounts.email.maildirBasePath = "Mail";
  data.persistence.directories = [
    "Mail"
  ];
}
