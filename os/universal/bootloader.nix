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

        resolution = "2560x1600";

        maxGenerations = 4;
        secureBoot = {
          enable = true;
          autoGenerateKeys = true;
          autoEnrollKeys = {
            enable = true;
            extraArgs = [
              "--microsoft"
              "--firmware-builtin"
            ];
          };
        };
        extraEntries = ''
          /Ubuntu
            protocol: efi
            path: boot():/EFI/ubuntu/shimx64.efi
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
