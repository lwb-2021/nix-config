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
  })
  (final: prev: {
    # TODO: https://github.com/NixOS/nixpkgs/pull/549747
    frei0r = (
      prev.callPackage (prev.fetchurl {
        url = "https://github.com/nick-linux8/nixpkgs/raw/da903b7c11233ac14b4203a98cff6a6b2f4302e5/pkgs/by-name/fr/frei0r/package.nix";
        hash = "sha256-frIW5EhPcCGYaW1E6vYMMqaUWexREHfcrqmYYB+FvEo=";
      }) { }
    );
    gavl = (
      prev.callPackage (prev.fetchurl {
        url = "https://github.com/nick-linux8/nixpkgs/raw/da903b7c11233ac14b4203a98cff6a6b2f4302e5/pkgs/by-name/ga/gavl/package.nix";
        hash = "sha256-lvo//8Qo9ik882r7u4lBZrtc9Q4IKqBCsCcmMRMmH8w=";
      }) { }
    );

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
