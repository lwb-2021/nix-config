{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.theming.fonts.enable {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = [ config.theming.fonts.sansSerif.name ];
          serif = [ config.theming.fonts.sansSerif.name ];
          monospace = [ config.theming.fonts.monospace.name ];
        };
      };
    };
  };
}
