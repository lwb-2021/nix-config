{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (prismlauncher.override {
      # Add binary required by some mod
      additionalPrograms = [
        ffmpeg
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

  services.restic.backups."minecraft" = {

    repository = "/data/backup/minecraft";
    passwordFile = config.sops.secrets."restic/password".path;

    dynamicFilesFrom = "find ${config.xdg.dataHome}/PrismLauncher -name \"level.dat\" -exec dirname {} \\;";
    extraBackupArgs = [
      "--group-by"
      "paths"
    ];
  };

  data.local.directories = [ ".local/share/PrismLauncher" ];
}
