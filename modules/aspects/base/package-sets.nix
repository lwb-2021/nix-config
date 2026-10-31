{ ... }: {

  flake-file.inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nur.url = "github:nix-community/NUR";

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs = {
        nixpkgs.autoFollow = false;
        home-manager.autoFollow = false;
      };
    };
  };

  flake.aspects.base = {
    nixos =
      { inputs, ... }@params:
      {
        imports = [ inputs.chaotic.nixosModules.default ];
        chaotic.nyx.cache.enable = false;
        nixpkgs = {
          overlays = import ./_nixpkgs/overlays.nix params;
        };
      };
    hm = {
    };
  };

}
