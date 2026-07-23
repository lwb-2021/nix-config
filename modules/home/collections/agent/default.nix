{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options = with lib; {
    collections.agent = {
      enable = mkEnableOption { };
      # TODO: option for model
    };
  };
  config =
    let
      cfg = config.collections.agent;
      pi-config-root = (
        lib.removePrefix config.home.homeDirectory config.programs.pi-coding-agent.configDir
      );
      ext-config = name: "${pi-config-root}/extensions/${name}/config.json";
    in
    lib.mkIf cfg.enable {
      collections.modern-shell.enable = lib.mkDefault true;
      programs.pi-coding-agent = {
        enable = true;
        context = ./context.md;
        extraPackages = with pkgs; [
          nodejs
          rtk
        ];
        models = {
          providers = {
            # openrouter = {
            #   apiKey = "!pass API/OpenRouter/Default";
            # };
            opencode = {
              apiKey = "!pass API/OpenCodeZen/Default";
            };
          };
        };
        settings = {
          # TODO
          defaultProvider = "opencode";
          defaultModel = "deepseek-v4-flash-free";
          defaultThinkingLevel = "medium";
          packages = [
            # Basic
            "npm:@gotgenes/pi-permission-system"
            "npm:pi-rtk-optimizer"
            "npm:pi-fast-resume"
            "npm:pi-workspace-history"

            # Tools
            "npm:pi-smart-fetch"
          ];
        };
      };
      home.file.${(ext-config "pi-permission-system")}.text =
        let
          whitelist = import ./bash-whitelist.nix;
        in
        builtins.toJSON {
          permission = {
            "*" = "ask";
            read = "allow";

            # TODO: fully disable
            grep = "deny";
            find = "deny";

            web_fetch = "allow";
            batch_web_fetch = "allow";

            path = {
              "*" = "allow";
              "*.env" = "deny";
              "*.env.*" = "deny";
              "*.env.example" = "allow";
            };
            bash = builtins.listToAttrs (
              map (name: {
                name = "${name} *";
                value = "allow";
              }) whitelist
            );
            external_directory = {
              "~/.cargo/registry/*" = "allow";
              "/tmp/*" = "allow";
            };
          };
        };

      programs.mcp = {
        enable = true;
      };

      home.file.".agents/skills" = {
        source = "${inputs.skills}/skills";
        recursive = true;
      };

      data.persistence.directories = [
        ".local/share/opencode" # OpenCode Sessions & Data
        pi-config-root
      ];
    };
}
