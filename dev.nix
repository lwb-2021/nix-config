{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nixd

        nvd
        nix-diff

        just
      ];
    };
  };
}
