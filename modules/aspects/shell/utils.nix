{ ... }: {
  flake.aspects.shell = {
    nixos = { };
    hm =
      {
        config,
        pkgs,
        inputs,
        ...
      }:
      {
        imports = [
          inputs.nix-index-database.homeModules.default
        ];

        programs.fzf = {
          enable = true;
          historyWidget.command = ""; # Disable history widget
        };
        programs.nix-index-database = {
          comma.enable = true;
        };

        home.packages = with pkgs; [
          (xonsh.override {
            extraPackages = (
              ps:
              config.programs.python.extraPackages
              ++ (with pkgs.nur.repos.xonsh-xontribs; [
                xonsh-direnv
              ])
            );
          })
        ];

        data.persistence.files = [
          ".local/state/comma/choices"
        ];
      };
  };
}
