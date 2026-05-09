{ config, pkgs, ... }:
{
  imports = [
    ./enc-tools.nix
    ./ssh.nix
    ./keepassxc.nix
    ./keyring.nix
  ];
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (
      ps: with ps; [
        pass-otp
        (pass-import.overrideAttrs {
          patches = [
            (pkgs.fetchpatch {
              url = "https://github.com/roddhjav/pass-import/pull/232.diff";
              hash = "sha256-Dbtvadd0TeJOKwi0FbfS6giV4Vj8p+TdSALQpTK6sXw=";
            })
          ];
        })
        pass-update
      ]
    );
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.local/share/password-store";
    };
  };
  programs.browserpass = {
    enable = true;
    browsers = [ "firefox" ];
  };
  # services.pass-secret-service.enable = true;

  home.packages = with pkgs; [
    pass-git-helper
  ];
  data.local.directories = [
    ".local/share/password-store"
  ];
}
