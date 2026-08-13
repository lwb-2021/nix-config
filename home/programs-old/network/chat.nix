{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fluffychat
  ];
  data.local.directories = [ ".local/share/chat.fluffy.fluffychat" ];
}
