{ ... }: {
  flake.aspects.desktop = {
    nixos = { };
    hm = {
      imports = [ ./_hm ];
    };
  };
}
