{ config, lib, ... }:
let
  mkTmpfilesOption =
    _:
    lib.mkOption {
      type =
        with lib.types;
        (attrsOf (
          submodule (
            { name, ... }:
            {
              options = with lib; {
                text = mkOption {
                  type = types.str;
                };
                source = mkOption {
                  type = types.str;
                };
                mode = mkOption {
                  type = types.str;
                  default = "0755";
                };
              };
            }
          )
        ));
      default = { };
    };
  mkTmpfileRule =
    parent: name: value:
    "C+ ${parent}/${name} ${value.mode} - - - ${value.source}";
  mapOptionToRules = parent: cfg: builtins.attrValues (builtins.mapAttrs (mkTmpfileRule parent) cfg);
in
{
  options = {
    home.tmpfiles = {
      configFile = mkTmpfilesOption { };
      dataFile = mkTmpfilesOption { };
    };
  };
  config =
    let
      cfg = config.home.tmpfiles;
    in
    {
      systemd.user.tmpfiles.rules = lib.mkMerge [
        (mapOptionToRules config.xdg.configHome cfg.configFile)
        (mapOptionToRules config.xdg.dataHome cfg.dataFile)
      ];
    };
}
