{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
rec {
  mkNixPakInner = inputs.nixpak.lib.nixpak {
    inherit lib;
    inherit pkgs;
  };
  mkNixPak =
    p:
    (mkNixPakInner (
      p
      // {
        specialArgs = {
          homeConfig = config;
        };

      }
    ));

  mkPersistSloth = sloth: path: [
    (sloth.mkdir (sloth.concat' sloth.appDir path))
    (sloth.concat' sloth.homeDir path)
  ];
}
