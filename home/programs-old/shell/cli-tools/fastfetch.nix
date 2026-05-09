{ lib, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        separator = "    ";
        constants = [ "───────────────────────────────" ];
      };
      modules =
        let
          key = "│ ├ {icon} ";
          genGroup = (
            name: type: keyColor: items:
            (
              [
                {
                  inherit type keyColor;
                  key = "{icon} ${name}";
                }
              ]
              ++ (builtins.map (type: {
                inherit type key keyColor;
              }) items)
            )
          );

          colors = {
            type = "custom";
            format = "{#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}  {#38}  {#39}       {#38}  {#37}  {#36}  {#35}  {#34}  {#33}  {#32}  {#31}  {#90} ";
          };

        in
        lib.flatten [
          {
            type = "custom";
            format = "╭{$1}{$1}╮";
            outputColor = "90";
          }
          (genGroup "PC  " "host" "red" [
            "cpu"
            "gpu"
            "memory"
            "swap"
            "btrfs"
            "battery"
            "poweradapter"
          ])

          (genGroup "OS  " "os" "yellow" [
            "kernel"
            "packages"
            "shell"
          ])
          (genGroup "WM  " "wm" "green" [
            "lm"
            "theme"
            "icons"
            "font"
            "cursor"
            "terminal"
            "locale"
          ])
          {
            type = "custom";
            format = "╰{$1}{$1}╯";
            outputColor = "90";
          }
          "break"
          colors
        ];
    };
  };
  programs.fish.shellInitLast = ''
    status is-interactive; and test $TMUX; and fastfetch
  '';
}
