{ inputs, ... }:
[
  (final: prev: {
    nur = import inputs.nur {
      nurpkgs = prev;
      pkgs = prev;
    };
    noCuda = import inputs.nixpkgs {
      localSystem = "x86_64-linux";
      config = {
        cudaSupport = false;
      };
    };
  })
  (final: prev: {
    thunar-archive-plugin = prev.thunar-archive-plugin.overrideAttrs (_: {
      postInstall = ''
        cp ${prev.xarchiver}/libexec/thunar-archive-plugin/* $out/libexec/thunar-archive-plugin/
      '';
    });

  })
  (final: prev: {

  })
  (final: prev: {
  })
  inputs.nix-vscode-extensions.overlays.default
]
