{ ... }: {
  # TODO: https://github.com/NixOS/nixpkgs/pull/538842
  flake-file.inputs = {
    flyline.url = "github:HalFrgrd/flyline";
  };
  flake.aspects.shell = {
    nixos = { inputs, ... }: {
      imports = [
        inputs.flyline.nixosModules.default
      ];

      programs.flyline.enable = true;
    };
  };
}
