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
        # TODO: https://github.com/roddhjav/pass-import/pull/232
        (pass-import.overrideAttrs {
          patches = [ ./0001-audit-tolerate-long-passwords.patch ];
        })
        pass-update
      ]
    );
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.local/share/password-store";
    };
  };
  # services.pass-secret-service.enable = true;

  home.packages = with pkgs; [
    pass-git-helper
  ];
  data.local.directories = [
    ".local/share/password-store"
  ];
}
