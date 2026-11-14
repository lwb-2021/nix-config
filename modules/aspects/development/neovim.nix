{ ... }: {
  flake.aspects.development = {
    nixos = { };
    hm =
      {
        config,
        pkgs,
        inputs,
        ...
      }:
      {

        home.packages = [
          inputs.dotfiles.packages.${pkgs.stdenv.hostPlatform.system}.neovim
        ];

        programs.neovide = {
          enable = true;
          settings = {
            maximized = false;
            startup-message-capture = false;
            font = {
              normal = "monospace";
              size = config.theming.fonts.sizes.terminal;
            };
            box-drawing = {
              mode = "native";
            };
          };
        };

        xdg.mimeApps.defaultApplications = {
          "text/plain" = "neovide.desktop";
          "text/markdown" = "neovide.desktop";
        };

        data.local.directories =
          let
            persist-state = name: ".local/state/nvim/${name}";
          in
          map persist-state [
            "backup"
            "blink"
            "lazy"
            "shada"
            "undo"
          ] ++ [".local/share/nvim"];
      };
  };
}
