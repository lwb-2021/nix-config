{ ... }: {
  flake.aspects.base = {
    nixos = { lib, inputs, ... }: {
      system.extraDependencies =
        let
          filterValidInputs = lib.filterAttrs (n: v: n != "self" && builtins.isAttrs v && v ? outPath);

          startSet = lib.mapAttrsToList (name: input: {
            key = input.outPath;
            value = input;
          }) (filterValidInputs inputs);

          allFlakeInputsClosure = builtins.genericClosure {
            inherit startSet;
            operator =
              { value, ... }:
              lib.mapAttrsToList (name: input: {
                key = input.outPath;
                value = input;
              }) (filterValidInputs (value.inputs or { }));
          };

          allFlakeInputs = map (node: node.value) allFlakeInputsClosure;
        in
        allFlakeInputs;
    };
  };
}
