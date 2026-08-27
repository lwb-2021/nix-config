{ pkgs, ... }:
{
  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings = {
      connect-timeout = 5;
      max-jobs = 8;
      cores = 8;

      log-lines = 25;

      max-free = (3000 * 1024 * 1024);
      min-free = (512 * 1024 * 1024);

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
    };
    extraOptions = ''
      keep-derivations = true
    '';

    # From nix-community/servo
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

  };
  systemd.services.nix-gc.serviceConfig = {
    CPUSchedulingPolicy = "batch";
    IOSchedulingClass = "idle";
    IOSchedulingPriority = 7;
  };
  systemd.slices.anti-hungry.sliceConfig = {
    CPUQuota = "400%";
    CPUAffinity = "1-4";

    IOWeight = 10;

    MemoryAccounting = true; # Allow to control with systemd-cgtop
    MemoryHigh = "50%";
    MemoryMax = "60%";
    MemorySwapMax = "60%";
    MemoryZSwapMax = "60%";
  };
  systemd.services.nix-daemon.serviceConfig = {
    Slice = "anti-hungry.slice";

    # Please kill nix builder when it eats up all my memory
    OOMScoreAdjust = 500;
  };

  # Optimise storage
  # you can also optimise the store manually via:
  #    nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
}
