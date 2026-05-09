{ inputs, my-utils, ... }:
{
  lwb = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs my-utils; };
    modules = [
      ../../modules/universal
      ../../modules/os

      inputs.impermanence.nixosModules.impermanence
      inputs.stylix.nixosModules.stylix
      inputs.sops-nix.nixosModules.sops
      inputs.nix-flatpak.nixosModules.nix-flatpak

      inputs.home-manager.nixosModules.home-manager

      ../../secrets/lwb/os.nix

      ../../os/desktop

      ../../services/openlist

      {

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm.bak";
          users.lwb.imports = [
            ../../modules/universal
            ../../modules/home

            inputs.sops-nix.homeManagerModules.sops
            inputs.nix-flatpak.homeManagerModules.nix-flatpak

            inputs.vicinae.homeManagerModules.default
            inputs.niri.homeModules.niri
            inputs.noctalia.homeModules.default

            ../secrets/lwb/home.nix

            ../home/lwb.nix
          ];
          extraSpecialArgs = { inherit inputs my-utils; };

        };
      }
    ];
  };
}
