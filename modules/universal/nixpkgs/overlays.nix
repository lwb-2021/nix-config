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
    openldap = prev.openldap.overrideAttrs (_: {
      doCheck = false;
    }); # TODO https://github.com/NixOS/nixpkgs/issues/513245
  })
  (final: prev: {
  })
  inputs.nix-bwrapper.overlays.default
  inputs.nix-vscode-extensions.overlays.default
]
