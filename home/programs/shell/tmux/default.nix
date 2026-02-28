{ lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = lib.getExe pkgs.fish;

    mouse = true;
    extraConfig = ''
      set -g allow-passthrough on
    '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tmux-which-key;
        extraConfig = "set -g @tmux-which-key-xdg-enable 1";
      }
    ];
  };
  xdg.configFile = {
    "tmux/plugins/tmux-which-key/config.yaml".source = ./tmux-which-key.yaml;
  };
  home.tmpfiles.dataFile."tmux/plugins/tmux-which-key/init.tmux".source =
    "${pkgs.tmuxPlugins.tmux-which-key}/share/tmux-plugins/tmux-which-key/plugin/init.example.tmux";
}
