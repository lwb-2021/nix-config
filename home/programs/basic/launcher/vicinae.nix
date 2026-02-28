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
  services.vicinae = {
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
        "@knoopx/${inputs.vicinae-extensions.packages.${localSystem}.nix.name}" = {
          preferences = {
          };
        };
        "@tinkerbells/${inputs.vicinae-extensions.packages.${localSystem}.pass.name}" = {
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
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
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
  autostart.commands = [ "vicinae server" ];
}
