{
  config,
  lib,
  pkgs,
  ...
}:
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
    obsidian.enable = false;
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

  # Fix for kde theming
  # TODO: remove when fixed in stylix
  # Related: https://github.com/nix-community/stylix/issues/1958
  # https://github.com/nix-community/stylix/issues/2183
  xdg.configFile.kdeglobals.source =
    let
      themePackage = builtins.head (
        builtins.filter (
          p: builtins.match ".*stylix-kde-theme.*" (builtins.baseNameOf p) != null
        ) config.home.packages
      );
      colorSchemeSlug = lib.concatStrings (
        lib.filter lib.isString (builtins.split "[^a-zA-Z]" config.lib.stylix.colors.scheme)
      );
    in
    "${themePackage}/share/color-schemes/${colorSchemeSlug}.colors";

  home.packages = with pkgs; [
    gnome-themes-extra
  ];
}
