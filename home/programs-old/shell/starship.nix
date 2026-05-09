{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = " [λ](bold green)";
        error_symbol = " [λ](bold red)";
        vimcmd_symbol = "[N](blue)[λ](bold green)";
        vimcmd_visual_symbol = "[V](purple)[λ](bold green)";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
    };
  };
}
