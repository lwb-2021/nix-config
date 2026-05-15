{ inputs, ... }:
{
  lwb = inputs.home-manager.lib.homeManagerConfiguration {

    modules = [
      ../../modules/universal
      ../../modules/home

      inputs.sops-nix.homeManagerModules.sops
      inputs.stylix.homeModules.stylix
      inputs.nix-flatpak.homeManagerModules.nix-flatpak

      inputs.niri.homeModules.niri

      ../../home/lwb.nix
    ];
    extraSpecialArgs = { inherit inputs; };
  };
}
