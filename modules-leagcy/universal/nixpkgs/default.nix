{ lib, pkgs, ... }@params:
{
  nixpkgs = lib.mkIf (!(params ? osConfig)) {
    config = import ./config.nix { inherit lib pkgs; };
  };
}
