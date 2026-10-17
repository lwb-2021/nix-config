{ lib, ... }:
{
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  flake.aspects.persistence = {
    nixos =
      { config, inputs, lib, ... }:
      let
        hmUsers = lib.attrByPath [ "home-manager" "users" ] { } config;
        mkUserPreservations =
          pick: lib.mkMerge (lib.mapAttrsToList (username: hm: { ${username} = pick hm; }) hmUsers);
        hiddenMountOptions = [
          "x-gvfs-hide"
          "x-gdu.hide"
        ];
      in
      {
        imports = [ inputs.preservation.nixosModules.default ];

        preservation = {
          enable = true;
          preserveAt = {
            "/data/persistence" = {
              commonMountOptions = hiddenMountOptions;
              users = mkUserPreservations (hm: {
                directories = hm.data.persistence.directories;
                files = hm.data.persistence.files;
              });
            };
            "/data/local" = {
              commonMountOptions = hiddenMountOptions;
              users = mkUserPreservations (hm: {
                directories = hm.data.local.directories;
                files = hm.data.local.files;
              });
            };
          };
        };
      };

    # HM-facing side of preservation (itself has no HM module).
    # Declared here instead of home/data so standalone HM keeps type
    # checking; values are consumed by the NixOS glue above and only
    # take effect when HM runs as a NixOS module.
    hm =
      { lib, ... }:
      {
        options.data = {
          persistence = {
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
              description = "Home state preserved under /data/persistence; paths are relative to the home directory.";
            };
            files = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
              description = "Home files preserved under /data/persistence; paths are relative to the home directory.";
            };
          };
          local = {
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
              description = "Recyclable local state under /data/local; paths are relative to the home directory.";
            };
            files = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
              description = "Recyclable local files under /data/local; paths are relative to the home directory.";
            };
          };
        };
      };
  };
}
