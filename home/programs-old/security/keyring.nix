{ pkgs, ... }:
{
  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
    ];
  };

  home.packages = with pkgs; [
    gcr_4
    keyutils
    seahorse
  ];
  data.persistence.directories = [ ".local/share/keyrings" ];
}
