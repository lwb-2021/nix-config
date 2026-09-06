{ lib, ... }:
{
  options = with lib; {
    theming = {
      general = {
        defaultColorSchemeName = lib.mkOption {
          type = types.str;
        };
        opacity = {
          applications = mkOption { type = types.float; };
          terminal = mkOption { type = types.float; };
        };
      };

      fonts = {
        enable = mkEnableOption { };
        sansSerif = {
          name = mkOption { type = types.str; };
          package = mkOption { type = types.package; };
        };
        monospace = {
          name = mkOption { type = types.str; };
          package = mkOption { type = types.package; };
        };
        emoji = {
          package = mkOption { type = types.package; };
        };
        sizes = {
          applications = mkOption { type = types.ints.positive; };
          terminal = mkOption { type = types.ints.positive; };
        };
      };

      cursor = {
        enable = mkEnableOption { };
        name = mkOption { type = types.str; };
        package = mkOption { type = types.package; };
        size = mkOption { type = types.ints.positive; };
      };

      icons = {
        enable = mkEnableOption { };
        name = mkOption { type = types.str; };
        package = mkOption { type = types.package; };
      };

      gtk = {
        enable = mkEnableOption { };
        theme = {
          name = mkOption { type = types.str; };
          package = mkOption { type = types.package; };
        };
        font = {
          name = mkOption { type = types.str; };
          size = mkOption { type = types.ints.positive; };
        };
      };

      qt.enable = mkEnableOption { };

    };
  };
}
