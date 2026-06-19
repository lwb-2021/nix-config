{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    plugins = with pkgs.yaziPlugins; {
      drag = drag;
    };
    settings = {
      mgr = {
        ratio = [
          0
          4
          6
        ];
        sort_by = "natural";
      };
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
