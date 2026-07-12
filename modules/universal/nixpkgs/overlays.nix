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
    python3Packages = prev.python3Packages.override {
      overrides = python-final: python-prev: {
        inherit (final.master.python3Packages) catppuccin;
      };
    };
    inherit (final.master) catppuccin-gtk;
  })
  (final: prev: {
    # For wemeet and others
    # TODO: https://github.com/niri-wm/niri/pull/1791
    niri = prev.niri.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./niri-shm-fallback.patch
      ];
    });
  })

  inputs.nix-cachyos-kernel.overlays.default

  inputs.nix-vscode-extensions.overlays.default
]
