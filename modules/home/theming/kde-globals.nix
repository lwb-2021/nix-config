{
  config,
  lib,
  ...
}:
{
  # KDE theming fix
  # Related: https://github.com/nix-community/stylix/issues/1958
  # https://github.com/nix-community/stylix/issues/2183
  xdg.configFile.kdeglobals = lib.mkIf config.theming.gtk.enable {
    source =
      let
        themePackage = config.theming.gtk.theme.package;
        colorSchemeName = config.theming.gtk.theme.name;
      in
      "${themePackage}/share/color-schemes/${colorSchemeName}.colors";
  };
}
