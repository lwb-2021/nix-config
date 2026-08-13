{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      # Apperance
      tab_bar_style = "powerline";
      transparent_background_colors = "#1e1e2f #181826";
      disable_ligatures = "never";
      cursor_trail = "1";
      cursor_trail_decay = "0.1 0.4";
      pixel_scroll = "yes";

      shell = "nu";

      initial_window_width = "179c"; # $COLUMNS
      initial_window_height = "45c"; # $LINES

    };
  };
  programs.tmux.terminal = "xterm-kitty";
  desktop.default-applications.terminal = "kitty -1";
}
