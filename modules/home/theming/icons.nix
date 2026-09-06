{
  config,
  lib,
  ...
}:
{
  # Icons are applied through gtk.iconTheme in gtk.nix
  # This module exists for completeness
  config = lib.mkIf config.theming.icons.enable { };
}
