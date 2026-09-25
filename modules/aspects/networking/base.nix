{ ... }: {
  flake.aspects.networking = {
    nixos = { config, lib, ... }: {
      networking.nftables = {
        enable = true;
      };

    };
    hm = { };
  };
}
