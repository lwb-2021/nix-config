{ config, ... }: {
  fonts.packages = [
    config.theming.fonts.sansSerif.package
    config.theming.fonts.monospace.package
    config.theming.fonts.emoji.package
  ];
}
