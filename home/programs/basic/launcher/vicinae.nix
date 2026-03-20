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
  services.vicinae =
    let
      exts = inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      settings = {
        imports = [
          config.sops.templates."vicinae.json".path
        ];
        theme = {
          # name = "vicinae-dark";
          iconTheme = "BeautyLine";
        };
        window = {
          csd = true;
          rounding = 10;
        };

        faviconService = "twenty";

        providers = {
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
  wayland.launcher.exec = "vicinae toggle";
  autostart.commands = [ "vicinae server --config ${config.xdg.configHome}/vicinae/nix.json" ];
}
