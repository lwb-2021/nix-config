{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.hermes-agent.nixosModules.default ];
  config = lib.mkIf config.services.hermes-agent.enable {
    services.hermes-agent = {
      settings = {
        model = {
          base_url = "https://openrouter.ai/api/v1";
          default = "nvidia/nemotron-3-super-120b-a12b:free";
        };
        display = {
          interface = "tui";
          personality = "kawaii";
        };
        web = {
          backend = "searxng";
        };
      };
      environment = {
        SEARXNG_URL = "http://127.0.0.1:8080";
      };
      extraPackages = with pkgs; [ agent-browser ];
      environmentFiles = [ config.sops.secrets."hermes/secret-env".path ];
      addToSystemPackages = true;
    };
    services.searx = {
      enable = true;
      settings = {
        server = {
          port = 8080;
          bind_address = "127.0.0.1";
          secret_key = "I_dont_need_to_keep_it_secret_as_it_only_runs_on_my_machine";
        };
        search = {
          default_lang = "zh-CN";
          ban_time_on_fail = 5;
        };

      };
    };
  };
}
