{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (weechat.override {
      configure =
        { availablePlugins, ... }:
        {
          scripts = with pkgs.weechatScripts; [
            weechat-notify-send
          ];
        };
    })
    fluffychat
  ];
  data.local.directories = [ ".local/share/chat.fluffy.fluffychat" ];
}
