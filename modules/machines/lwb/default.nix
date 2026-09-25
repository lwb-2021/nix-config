{ inputs, ... }:
let
  my-utils = import ../../../utils/default.nix { inherit (inputs.nixpkgs) lib; };

  hm-modules =
    with inputs.self.modules.hm;
    [
      base
      theming
      development
      optim-desktop
      desktop
      networking
    ]
    ++ [
      ../../../modules-leagcy/universal
      ../../../modules-leagcy/home

      inputs.sops-nix.homeManagerModules.sops

      inputs.nix-flatpak.homeManagerModules.nix-flatpak
      inputs.noctalia.homeModules.default

      inputs.niri.homeModules.niri

      ../../../secrets/lwb/home.nix
      ../../../home/lwb.nix
    ];
in
{

  flake.homeConfigurations.lwb = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    modules = hm-modules;
    extraSpecialArgs = { inherit inputs my-utils; };
  };

  flake.nixosConfigurations.lwb = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs my-utils; };
    modules =
      with inputs.self.modules.nixos;
      [
        base
        theming
        development
        optim-desktop
        desktop
        networking
      ]
      ++ [
        ../../../modules-leagcy/universal
        ../../../modules-leagcy/os

        inputs.impermanence.nixosModules.impermanence

        inputs.sops-nix.nixosModules.sops
        inputs.nix-flatpak.nixosModules.nix-flatpak

        inputs.home-manager.nixosModules.home-manager

        ../../../secrets/lwb/os.nix

        ../../../os/desktop

        ({ lib, ... }: {
          networking.hostName = "lwb";

          hardware.facter.reportPath = ./facter.json;
          hardware.facter.detected.boot.graphics.kernelModules = lib.mkForce [ "i915" ]; # Remove NVIDIA from initrd
        })
        {

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm.bak";
            users.lwb.imports = hm-modules;
            extraSpecialArgs = { inherit inputs my-utils; };

          };
        }
      ];
  };

}
