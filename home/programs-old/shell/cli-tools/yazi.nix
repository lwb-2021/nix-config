{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    plugins = with pkgs.yaziPlugins; {
      drag = drag;
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "<C-d>" ];
          run = "plugin drag";
          desc = "Drag Files";
        }
      ];
    };
  };
  home.packages = with pkgs; [
    sshfs
    ripdrag
  ];
}
