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
    nix-bwrapper.url = "github:Naxdy/nix-bwrapper";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #

    my-neovim = {
      url = "github:lwb-2021/neovim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "git+https://github.com/noctalia-dev/noctalia-shell.git?shallow=1";
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
    inputs:
    let
      system = "x86_64-linux";

      my-utils = import ./utils/default.nix { inherit (inputs.nixpkgs) lib; };
    in
    import ./outputs my-utils { inherit inputs my-utils; };

}
