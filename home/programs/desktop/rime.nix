{ config, pkgs, ... }:
{
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-gtk
          (fcitx5-rime.override {
            rimeDataPkgs = with pkgs; [
              rime-ice
            ];
          })
        ];
        waylandFrontend = true;
        settings = {
          globalOptions = {
            Hotkey = {
              EnumerateWithTriggerKeys = true;
              "TriggerKeys/0" = "Alt+Shift+Shift_R";
            };
          };
        };
      };
    };
  };
  xdg.dataFile = {
    "fcitx5/rime/default.custom.yaml".text = ''
      patch:
        __include: rime_ice_suggestion:/
    '';
    "fcitx5/rime/default.yaml".text = "";
    "fcitx5/rime/installation.yaml".text = ''
      distribution_code_name: "fcitx-rime"
      distribution_name: Rime
      installation_id: "${config.home.username}-fcitx5"
    '';
  };
  data.local = {
    files = [ ".local/share/fcitx5/rime/user.yaml" ];
    directories = [
      ".local/share/fcitx5/rime/rime_ice.userdb"
    ];
  };
}
