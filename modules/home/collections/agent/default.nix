{
  config,
  lib,
  pkgs,
  ...
}:
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
    lib.mkIf cfg.enable {
      programs.opencode = {
        enable = true;
        enableMcpIntegration = true;
        context = builtins.readFile ./context.md;
        settings = {
          shell = "nu";
          lsp = {
            rust.command = [ (lib.getExe pkgs.rust-analyzer) ];
          };
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
              "/tmp/**" = "allow";
            };
          };
        };
      };
      programs.mcp = {
        enable = true;
      };
      home.sessionVariables = {
        OPENCODE_DISABLE_LSP_DOWNLOAD = "true";
        OPENCODE_EXPERIMENTAL_LSP_TOOL = "true";
      };

      data.persistence.directories = [
        ".local/share/opencode" # OpenCode Sessions & Data
      ];
      data.local.directories = [
        ".cache/opencode"
        ".config/opencode"
      ];
    };
}
