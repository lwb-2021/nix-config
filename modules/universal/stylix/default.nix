{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = ./themes/catppuccin.yaml;
    opacity = {
      applications = 0.8;
      desktop = 0.0;
      popups = 0.8;
      terminal = 0.8;
    };

    polarity = "dark";
    fonts = rec {
      sansSerif = {
        name = "Source Han Sans SC";
        package = pkgs.source-han-sans;
      };
      monospace = {
        name = "JetBrainsMono NF";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
      };
      serif = sansSerif;
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 14;
        popups = 14;
      };
    };
    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
    };
    icons = rec {
      dark = "BeautyLine";
      light = dark;
      package = pkgs.beauty-line-icon-theme;
    };

  };
}
