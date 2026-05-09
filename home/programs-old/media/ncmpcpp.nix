{ pkgs, ... }:
{
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
    };
    settings = {
      user_interface = "alternative";
      alternative_header_first_line_format = "$(white)─┤ $b$(magenta)%a$(end)$/b ├─$(end)";
      alternative_header_second_line_format = "$(16)%t (%y)$(end)";
      alternative_ui_separator_color = "cyan";
      progressbar_look = "▃▃▃";

      song_columns_list_format = "$L (10)[white]{n} $1│$7 (20)[magenta]{a} $1│$7 (20)[white]{b} $1│$7 (20)[magenta]{t} $1│$7 (20)[white]{l}";
      now_playing_prefix = "$b";
      centered_cursor = "no";
      cyclic_scrolling = "yes";
      mouse_list_scroll_whole_page = "no";

      visualizer_output_name = "FIFO";
      visualizer_in_stereo = "yes";
      visualizer_type = "spectrum";
      visualizer_look = "●●";
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_color = "blue, cyan, green, yellow, magenta, red";
    };
  };
}
