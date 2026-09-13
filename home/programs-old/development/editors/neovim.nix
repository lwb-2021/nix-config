{ pkgs, inputs, ... }:
{

  home.packages = [
    inputs.dotfiles.packages.${pkgs.stdenv.hostPlatform.system}.neovim
  ];
  programs.neovide = {
    enable = true;
    settings = {
      maximized = false;
      box-drawing = {
        mode = "native";
      };
    };
  };
  xdg.mimeApps.defaultApplications = {
    "text/plain" = "neovide.desktop";
    "text/markdown" = "neovide.desktop";
  };
  data.local.directories = [ ".local/share/nvim" ];
}
