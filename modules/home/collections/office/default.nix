{
  config,
  lib,
  pkgs,
  my-utils,
  inputs,
  ...
}@params:
{
  options = with lib; {
    collections.office = {
      enable = mkEnableOption { };
    };
  };

  config = {
    home.packages = lib.mkIf config.collections.office.enable (
      my-utils.mkListFromPath ./packages (
        params
        // {
          nixpak-utils = (import ./nixpak-utils params);
        }
      )
    );
    data.local.directories = lib.mkIf config.collections.office.enable [
      ".var/app/cn.feishu.Feishu"
    ];
  };
}
