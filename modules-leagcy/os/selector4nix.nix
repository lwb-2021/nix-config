{ inputs, ... }: {
  imports = [
    inputs.selector4nix.nixosModules.selector4nix
  ];
  services.selector4nix = {
    enable = true;
    enablePersistentCaching = true;
    configureSubstituter = "overwrite";
    settings = {

      network = {
        ignore_nar_info_error = true;
      };

      substituters =
        (map
          (url: {
            inherit url;
            priority = 1; # The higher the value, the lower the priority of this substituter

          })
          [
            # Mirrors
            "https://mirrors.cernet.edu.cn/nix-channels/store"
            "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
            "https://mirror.sjtu.edu.cn/nix-channels/store"
            "https://mirrors.ustc.edu.cn/nix-channels/store"
          ]
        )
        ++ (map
          (url: {
            inherit url;
          })
          [
            "https://cache.nixos.org"
            "https://cache.nixos-cuda.org"

            "https://nyx-cache.chaotic.cx/"

            "https://cache.flox.dev"

            "https://nix-community.cachix.org"
            "https://noctalia.cachix.org"
            "https://selector4nix.cachix.org/"
          ]
        );

    };
  };
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="

    "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="

    "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="

    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    "selector4nix.cachix.org-1:wovVlT07In5JCVz2tFgxPQTLpnN8hZT6P/RwfFcz3KE="

  ];

}
