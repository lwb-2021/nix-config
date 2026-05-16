{
  config,
  pkgs,
  inputs,
  ...
}:
let
  localSystem = pkgs.stdenv.hostPlatform.system;
in
{
  data.local.directories = [ ".local/share/vicinae" ]; # file-indexer.db is too large
  sops.templates."vicinae.json".content = ''
    {
    	"providers": {
    		"@knoopx/nix-0": {
    			"preferences": {
    				"githubToken": "${config.sops.placeholder."vicinae/nix/github-token"}"
    			}
    		}
    	}
    }
  '';
  programs.vicinae =
    let
      exts = inputs.vicinae-extensions.packages.${localSystem};
    in
    {
      enable = true;
      package = pkgs.vicinae;
      systemd = {
        enable = true;
        autoStart = true;
      };
      settings = {
        imports = [
          config.sops.templates."vicinae.json".path
        ];
        theme = {
          # name = "vicinae-dark";
          dark = {
            icon_theme = "BeautyLine";
          };
        };
        window = {
          csd = true;
          rounding = 10;
        };

        favicon_service = "twenty";

        providers = {
          applications = {
            preferences = {
              launchPrefix = "systemd-run --user --scope --slice=app.slice --";
            };
          };
          "@knoopx/${exts.nix.name}" = {
            preferences = {
            };
          };
          "@tinkerbells/${exts.pass.name}" = {
            preferences = {
              passwordStorePath = "~/.local/share/password-store";
            };
          };
          clipboard = {
            preferences = {
              encryption = true;
            };
          };
        };
      };
      extensions = with exts; [
        bluetooth
        firefox
        niri
        nix
        pass
        player-pilot
        process-manager
        wifi-commander
      ];
    };
  desktop.default-applications.launcher = "vicinae toggle";
}
