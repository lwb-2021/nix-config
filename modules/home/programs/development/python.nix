{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = with lib; {
    programs.python = {
      enable = mkEnableOption {
        default = false;
      };
      package = mkPackageOption pkgs "python3" { };
      pythonPackages = mkOption {
        type = types.listOf types.package;
        default = [ ];
      };
      finalPackage = mkPackageOption pkgs "python3" {
        nullable = true;
      };
    };
  };
  config = {
    programs.python.finalPackage = lib.mkDefault (
      config.programs.python.package.withPackages (ps: config.programs.python.pythonPackages)
    );
    home.packages = lib.mkIf config.programs.python.enable [
      config.programs.python.finalPackage
    ];
  };
}
