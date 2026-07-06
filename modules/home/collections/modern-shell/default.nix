{ config, lib, ... }: {
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
    };
  };
}
