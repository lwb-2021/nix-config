{ config, pkgs, ... }:
{
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    settings = {
      use_default_settings = {
        engines.remove = [
          "startpage" # Unable to access
        ];
      };
      server = {
        secret_key = "$SEARX_SECRET_KEY";
        host = "127.0.0.1";
        port = 8080;
      };
      engines = [
        {
          name = "baidu";
          engine = "baidu";
          shortcut = "baidu";
          disabled = false;
        }
        {
          name = "bing";
          engine = "bing";
          shortcut = "bing";
          disabled = false;
        }
      ];
    };
    environmentFile = config.sops.secrets."searx/env".path;
  };
}
