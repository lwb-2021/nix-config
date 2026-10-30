{ lib, ... }:
{
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  flake.aspects.persistence = {
    nixos =
      {
        config,
        inputs,
        lib,
        ...
      }:
      let
        hmUsers = lib.attrByPath [ "home-manager" "users" ] { } config;
        mkUserPreservations =
          pick: lib.mkMerge (lib.mapAttrsToList (username: hm: { ${username} = pick hm; }) hmUsers);
        hiddenMountOptions = [
          "x-gvfs-hide"
          "x-gdu.hide"
        ];
        # Peak observed: 86 mount events within one second. 200 leaves room to
        # spare while still catching a genuinely runaway mount loop.
        MOUNT_RATE_LIMIT = "SYSTEMD_DEFAULT_MOUNT_RATE_LIMIT_BURST=200";
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

        systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

        # preservation creates one bind mount per preserved path, and they are
        # all set up in a single burst: 86 mounts land within one second here.
        # systemd's mount event source is rate limited to 5 per second by
        # default, so everything past the fifth waits out a full 1s penalty
        # window (src/core/mount.c: "as it stalls the boot sequence on busy
        # systems"). Raise it for both PID 1 of the initrd and of the main
        # system; `ManagerEnvironment` is what lands in systemd's own environ,
        # which is what secure_getenv() reads.
        boot.initrd.systemd.settings.Manager.ManagerEnvironment = [ MOUNT_RATE_LIMIT ];
        systemd.settings.Manager.ManagerEnvironment = [ MOUNT_RATE_LIMIT ];
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
