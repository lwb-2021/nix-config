{ ... }: {
  flake.aspects.development = {
    nixos = { };
    hm = { pkgs, ... }: {
      programs.git = {
        enable = true;
      };

      programs.gh = {
        enable = true;
        hosts = {
          "github.com" = {
            git_protocol = "ssh";
            user = "lwb-2021";
          };
        };
      };
      home.packages = with pkgs; [
        commitizen-go
        commitlint-rs
        husky

        git-ignore

        just

        lazygit

        nixd
      ];

      data.local.files = [
        ".local/state/gh/device-id"
      ];

    };
  };
}
