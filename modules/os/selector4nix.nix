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
            "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
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

            "https://nix-community.cachix.org"
            "https://noctalia.cachix.org"
            "https://selector4nix.cachix.org/"
          ]
        )
        ++ [
          {
            url = "https://attic.xuyh0120.win/lantian";
            priority = 100;
          }

        ];

    };
  };
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="

    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    "selector4nix.cachix.org-1:wovVlT07In5JCVz2tFgxPQTLpnN8hZT6P/RwfFcz3KE="

    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
  ];

}
