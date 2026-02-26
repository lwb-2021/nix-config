{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (prismlauncher.override {
      # Add binary required by some mod
      additionalPrograms = [
        ffmpeg
        glfw3
      ];

      # Change Java runtimes available to Prism Launcher
      jdks = [
        jdk25
        jdk21
        jdk17
        jre8
      ];
    })
    gamemode
  ];
  data.local.directories = [ ".local/share/PrismLauncher" ];
}
