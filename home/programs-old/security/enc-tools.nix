{
  pkgs,
  ...
}:
{
  programs.gpg = {
    enable = true;
    settings = {

      # Algo
      personal-cipher-preferences = "AES256";
      personal-digest-preferences = "SHA512";
      default-preference-list = "SHA512 SHA384 SHA256 RIPEMD160 AES256 TWOFISH BLOWFISH ZLIB BZIP2 ZIP Uncompressed";
      cipher-algo = "AES256";
      digest-algo = "SHA512";
      cert-digest-algo = "SHA512";
      compress-algo = "ZLIB";
      disable-cipher-algo = "3DES";
      weak-digest = "SHA1";
      s2k-cipher-algo = "AES256";
      s2k-digest-algo = "SHA512";
      s2k-mode = "3";
      s2k-count = "65011712";
    };
  };
  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
    pinentry.package = pkgs.pinentry-gnome3;
    extraConfig = ''
      allow-preset-passphrase
    '';
  };
  xdg.configFile."pam-gnupg".text = ''
    EFE4C9541F27C5A3D6A848720893F1A121010CDF
  '';
  data = {
    local.directories = [
      ".gnupg" # TODO
    ];
    persistence.directories = [ ".config/sops" ]; # TODO
  };

  home.packages = with pkgs; [
    age
  ];
}
