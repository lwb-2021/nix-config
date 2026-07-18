{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waylyrics
  ];
  home.tmpfiles.configFile."waylyrics/config.toml".source = toString (
    pkgs.writers.writeTOML "waylyrics.toml" {
      show-default-text-on-idle = false;
      show-lyrics-on-pause = false;
      player-name-blacklist = [ ];
    }
  );
}
