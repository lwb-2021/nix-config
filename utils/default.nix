{ lib, ... }:
rec {
  scanNixModules =
    path:
    builtins.attrNames (
      lib.attrsets.filterAttrs (
        path: _type:
        (_type == "directory") # include directories
        || (
          (path != "default.nix") # ignore default.nix
          && (lib.strings.hasSuffix ".nix" path) # include .nix files
        )
      ) (builtins.readDir path)
    );
  mkImportAll = path: map (f: (path + "/${f}")) (scanNixModules path);
  mkAttrsetFromPath =
    path: args:
    (builtins.listToAttrs (
      map (f: {
        name = lib.removeSuffix ".nix" f;
        value = import (path + "/${f}") args;
      }) (scanNixModules path)
    ));
}
