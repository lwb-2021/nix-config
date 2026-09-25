{ ... }: {
  flake.aspects.theming = {
    nixos = { config, lib, ... }: {
      options = import ./_options.nix lib;

      config =
        let
          cfg = config.theming.fonts;
        in
        lib.mkIf cfg.enable {
          fonts = {
            fontconfig = {
              enable = true;
              defaultFonts = {
                sansSerif = [ cfg.sansSerif.name ];
                serif = [ cfg.sansSerif.name ];
                monospace = [ cfg.monospace.name ];
                emoji = [ cfg.emoji.name ];
              };
            };
            packages = with cfg; [
              sansSerif.package
              monospace.package
              emoji.package
            ];
          };
        };
    };
    hm = { config, lib, ... }: {
      options = import ./_options.nix lib;
    };

  };
}
