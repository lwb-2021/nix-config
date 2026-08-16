{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    accentColor = "base07";
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
        name = "JetBrains Maple Mono";
        package = pkgs.nur.repos.lwb-2021.jetbrains-maple-mono-nerd;
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
      };
      serif = sansSerif;
      sizes = {
        applications = 12;
        terminal = 14;
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
