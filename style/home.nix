{ pkgs, ... }:
{
  stylix.targets = {
    firefox.enable = false;
    qt = {
      enable = true;
      platform = "qtct";
    };
    gtk = {
      colors.enable = false;
      flatpakSupport.enable = true;
    };
    noctalia-shell.enable = false;
  };
  gtk = {
    theme = {
      name = "catppuccin-mocha-mauve-standard+float,rimless";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        tweaks = [
          "float"
          "rimless"
        ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "BeautyLine";
      package = pkgs.beauty-line-icon-theme;
    };
    colorScheme = "dark";
  };
  home.packages = with pkgs; [
    gnome-themes-extra
  ];
}
