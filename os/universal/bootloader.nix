{ pkgs, ... }:
{
  boot = {
    tmp.useTmpfs = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      limine = {
        enable = true;
        efiSupport = true;
        maxGenerations = 4;
        secureBoot = {
          enable = true;
        };
        extraEntries = ''
          /Windows 11
              protocol: efi
              path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };

    };
    initrd = {
      systemd = {
        enable = true;
      };
    };
    # UKI is automatically enabled
  };
  environment.systemPackages = with pkgs; [
    sbctl
  ];

}
