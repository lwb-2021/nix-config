{ ... }:
{
  programs.fastfetch = {
    enable = true;
  };
  programs.fish.shellInitLast = ''
    status is-interactive; and test $TMUX; and fastfetch
  '';
}
