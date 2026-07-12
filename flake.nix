{
  description = "My NixOS flake";
  inputs = {
    nixpkgs.url = "git+https://mirrors.cernet.edu.cn/nixpkgs.git?shallow=1&ref=nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Modules

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:lwb-2021/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Applications

    hermes-agent = {
      url = "git+https://github.com/NousResearch/hermes-agent?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    my-neovim = {
      url = "github:lwb-2021/neovim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia.url = "git+https://github.com/noctalia-dev/noctalia-shell.git?ref=cachix&shallow=1";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae-extensions = {
      url = "git+https://github.com/vicinaehq/extensions?shallow=1";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Resources
    bt-tracker-list = {
      url = "github:XIU2/TrackersListCollection";
      flake = false;
    };
  };
  outputs =
    inputs:
    let
      system = "x86_64-linux";

      my-utils = import ./utils/default.nix { inherit (inputs.nixpkgs) lib; };
    in
    import ./outputs my-utils { inherit inputs my-utils; };

}
