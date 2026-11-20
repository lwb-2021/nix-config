{ inputs, ... }: {
  imports = [
    inputs.flake-aspects.flakeModule

    (inputs.import-tree ./modules)

    ./dev.nix
    ./legacy-inputs.nix
  ]
  ++ (with inputs.flake-file.flakeModules; [
    default
    auto-follow
  ]);

  systems = [
    "x86_64-linux"
  ];

  flake-file = {
    description = "My NixOS Configuration";
    inputs = {
      import-tree.url = "github:denful/import-tree";

      flake-file.url = "github:denful/flake-file";

      flake-parts.url = "github:hercules-ci/flake-parts";
      flake-aspects.url = "github:denful/flake-aspects";

    };
    outputs = "inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ./flake-file.nix";
    formatter = pkgs: pkgs.nixfmt;
  };
}
