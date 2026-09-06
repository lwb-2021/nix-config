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
  mkWrap =
    name: params:
    pkgs.symlinkJoin {
      name = "${name}-wrapped";
      paths = [ pkgs.${name} ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        for f in $out/bin/*; do
          wrapProgram "$f" \
            --prefix PATH : ${
              pkgs.lib.makeBinPath [
                pkgs.coreutils
                pkgs.flatpak-xdg-utils
              ]
            }
        done
      '';
    };
}
