{ pkgs, inputs, ... }:
{

  home.packages = [
    inputs.my-neovim.packages.${pkgs.stdenv.hostPlatform.system}.default
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
}
