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
    master = import inputs.nixpkgs-master {
      localSystem = "x86_64-linux";
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
    inherit (prev.lixPackageSets.stable)
      nixpkgs-review
      # nix-direnv # No need to add this and this also causes error
      nix-eval-jobs
      nix-fast-build
      colmena
      ;
  })

  (final: prev: {
  })
  (final: prev: {
    # For wemeet and others
    # TODO: https://github.com/niri-wm/niri/pull/1791
    niri = final.master.niri.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./niri-shm-fallback.patch
      ];
    });
  })

  inputs.nix-cachyos-kernel.overlays.default

  inputs.nix-vscode-extensions.overlays.default
]
