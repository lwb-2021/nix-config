{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (jetbrains.idea.override {
      forceWayland = true;
    })
  ];
  data.local.directories = [
    ".local/share/JetBrains"
    ".config/JetBrains"
  ];

}
