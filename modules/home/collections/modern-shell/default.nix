{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-index-database.homeModules.default
  ];
  options = with lib; {
    collections.modern-shell = {
      enable = mkEnableOption { };
    };
  };
  config = {
    programs = lib.mkIf config.collections.modern-shell.enable {
      fzf = {
        enable = true;
        historyWidget.command = ""; # Disable history widget
      };
      nix-index-database = {
        comma.enable = true;
      };
    };
  };
}
