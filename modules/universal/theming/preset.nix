{ lib, pkgs, ... }:
{
  theming = {
    general = {
      defaultColorSchemeName = "noctalia";
      opacity = {
        applications = 0.6;
        terminal = 0.6;
      };
    };
    fonts = {
      enable = true;
      sansSerif = {
        name = "Source Han Sans SC";
        package = pkgs.source-han-sans;
      };
      monospace = {
        name = "JetBrains Maple Mono";
        package = pkgs.nur.repos.lwb-2021.jetbrains-maple-mono-nerd;
      };
      emoji.package = pkgs.noto-fonts-color-emoji;
      sizes = {
        applications = 12;
        terminal = 14;
      };
    };

    cursor = {
      enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 32;
    };

    icons = {
      enable = true;
      name = "BeautyLine";
      package = pkgs.beauty-line-icon-theme;
    };

    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-mocha-lavender-standard+float,rimless";
        package = (pkgs.catppuccin-gtk.override {
          accents = [ "lavender" ];
          tweaks = [ "float" "rimless" ];
          variant = "mocha";
        });
      };
      font = {
        name = "Source Han Sans SC";
        size = 12;
      };
    };

    qt.enable = true;
  };
}
