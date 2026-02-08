{
  description = "My NixOS flake";
  inputs = {
    nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?shallow=1&ref=nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #

    # ags = {
    #   url = "github:Aylur/ags";
    # };
    my-neovim = {
      url = "github:lwb-2021/neovim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae = {
      url = "git+https://github.com/vicinaehq/vicinae?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae-extensions = {
      url = "git+https://github.com/vicinaehq/extensions?shallow=1";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        vicinae.follows = "vicinae";
      };
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit
          (import ./nixpkgs-settings {
            inherit inputs;
            inherit (nixpkgs) lib;
          })
          config
          overlays
          ;
        localSystem = {
          inherit system;
        };

      };
    in
    {
      nixosConfigurations.lwb = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = { inherit inputs; };
        modules = [

          inputs.impermanence.nixosModules.impermanence
          inputs.stylix.nixosModules.stylix
          inputs.sops-nix.nixosModules.sops
          inputs.nix-flatpak.nixosModules.nix-flatpak

          inputs.home-manager.nixosModules.home-manager

          ./secrets/lwb/os.nix

          ./style

          ./os/desktop

          ./services/openlist

          {

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm.bak";
              users.lwb.imports = [
                inputs.sops-nix.homeManagerModules.sops
                inputs.nix-flatpak.homeManagerModules.nix-flatpak

                inputs.vicinae.homeManagerModules.default
                inputs.niri.homeModules.niri
                inputs.noctalia.homeModules.default

                ./style
                ./style/home.nix

                ./secrets/lwb/home.nix

                ./home/lwb.nix
              ];
              extraSpecialArgs = { inherit inputs; };

            };
          }
        ];
      };
      homeConfigurations.lwb = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          inputs.sops-nix.homeManagerModules.sops
          inputs.stylix.homeModules.stylix
          inputs.nix-flatpak.homeManagerModules.nix-flatpak

          inputs.vicinae.homeManagerModules.default
          inputs.niri.homeModules.niri

          ./style
          ./style/home.nix

          ./home/lwb.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
