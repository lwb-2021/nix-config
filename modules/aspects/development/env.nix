{ ... }: {
  flake.aspects.development = {
    nixos = { };
    hm = {
      services.lorri.enable = true;
    };
  };
}
