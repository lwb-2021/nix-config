{ ... }: {

  flake-file.inputs = {
    nixpkgs.url = "git+https://mirrors.cernet.edu.cn/nixpkgs.git?shallow=true&ref=nixos-unstable";
    nixpkgs-master.url = "git+https://mirrors.cernet.edu.cn/nixpkgs.git?shallow=true&ref=master";
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
