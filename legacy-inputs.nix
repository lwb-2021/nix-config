{
  flake-file.inputs = {

    # Dotfiles

    dotfiles.url = "github:lwb-2021/dotfiles";

    # Modules

    home-manager.url = "github:nix-community/home-manager";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Applications

    niri.url = "github:epireyn/niri-flake";

    nix-index-database.url = "github:nix-community/nix-index-database";

    noctalia = {
      url = "git+https://github.com/noctalia-dev/noctalia-shell.git?ref=cachix&shallow=true";
      inputs.nixpkgs.autoFollow = false;
    };
    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";

    selector4nix = {
      url = "github:StarryReverie/selector4nix";
      inputs.nixpkgs.autoFollow = false;

    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    vicinae-extensions = {
      url = "git+https://github.com/vicinaehq/extensions?shallow=true";
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

}
