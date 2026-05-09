{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
  };

  programs.gh = {
    enable = true;
    hosts = {
      "github.com" = {
        git_protocol = "ssh";
        user = "lwb-2021";
      };
    };
  };
  home.packages = with pkgs; [
    commitizen-go
    commitlint-rs
    husky
    lazygit
    git-ignore
  ];

  programs.jujutsu = {
    enable = true;
    settings = {
      user = config.programs.git.settings.user;
    };
  };
  programs.jjui.enable = true;
}
