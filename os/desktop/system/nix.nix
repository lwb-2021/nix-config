{
  ...
}:
{
  nix = {
    settings = {
      connect-timeout = 5;
      max-jobs = 8;

      log-lines = 25;

      max-free = (3000 * 1024 * 1024);
      min-free = (512 * 1024 * 1024);

      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];

      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos-cuda.org"

        "https://noctalia.cachix.org"
        "https://attic.xuyh0120.win/lantian"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="

        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="

        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
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
    CPUAccounting = true;
    CPUQuota = "1200%";

    IOWeight = 10;

    MemoryAccounting = true; # Allow to control with systemd-cgtop
    MemoryWeight = 10;
    MemoryHigh = "80%";
    MemoryMax = "85%";
    MemorySwapMax = "80%";
    MemoryZSwapMax = "80%";
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
