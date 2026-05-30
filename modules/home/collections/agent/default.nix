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
          lsp = true;
          plugin = [ "opencode-pty" ];
          permission = {
            bash = {
              "*" = "ask";

              "git diff *" = "allow";
              "git log *" = "allow";
              "git status" = "allow";
            };
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
      home.sessionVariables = {
        OPENCODE_DISABLE_LSP_DOWNLOAD = "true";
      };
      data.local.directories = lib.mkIf cfg.enable [
        ".cache/opencode"
        ".config/opencode"
      ];
    };
}
