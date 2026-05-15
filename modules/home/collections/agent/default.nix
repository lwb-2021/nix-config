{ config, lib, ... }:
{
  options = with lib; {
    collections.agent = {
      enable = mkEnableOption { };
    };
  };
  config =
    let
      cfg = config.collections.agent;
    in
    {
      programs.opencode = {
        enable = cfg.enable;
        enableMcpIntegration = true;
        context = builtins.readFile ./context.md;
        settings = {
          plugin = [ "opencode-pty" ];
          permission = {
            bash = "ask";
            edit = "ask";
            external_directory = {
              "~/Configurations/**" = "allow";
            };
          };
        };
      };
      programs.mcp = {
        enable = cfg.enable;
      };
      data.local.directories = lib.mkIf cfg.enable [
        ".cache/opencode"
        ".config/opencode"
      ];
    };
}
