{ inputs, my-utils, ... }:
{
  lwb = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    modules = [
      ../../modules/universal
      ../../modules/home

      inputs.sops-nix.homeManagerModules.sops
      inputs.stylix.homeModules.stylix
      inputs.nix-flatpak.homeManagerModules.nix-flatpak
      inputs.noctalia.homeModules.default

      inputs.niri.homeModules.niri

      ../../secrets/lwb/home.nix
      ../../home/lwb.nix
    ];
    extraSpecialArgs = { inherit inputs my-utils; };
  };
}
