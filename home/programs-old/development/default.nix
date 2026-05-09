{
  pkgs,
  ...
}:
{
  imports = [ ./cache-persist.nix ];
  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

}
