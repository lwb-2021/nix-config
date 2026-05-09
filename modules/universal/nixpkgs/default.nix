{
  lib,
  inputs,
  ...
}@params:
{
  nixpkgs = lib.mkIf (!(params ? osConfig)) {
    config = import ./config.nix { inherit lib; };
    overlays = import ./overlays.nix { inherit inputs; };
  };
}
