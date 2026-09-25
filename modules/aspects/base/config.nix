{ ... }: {
  flake.aspects.base = {
    nixos = { };
    hm = {
      home.sessionVariables = {
        NH_FLAKE = "$HOME/Configurations/nix-config";
      };
    };
  };
}
