{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains.idea
  ];
  data.local.directories = [
    ".local/share/JetBrains"
    ".config/JetBrains"
  ];

}
