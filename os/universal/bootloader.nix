{ config, lib, pkgs, ... }:
let
  activationScripts = config.system.activationScripts;
  scriptText = x: if builtins.isString x then x else x.text or "";
  whitelisted = [
    "binsh"
    "usrbinenv"
    "modprobe"
    "specialfs"
    "udevd"
    "etc"
    "script"
  ];
  offenders = lib.filter (
    name: !(lib.elem name whitelisted) && scriptText activationScripts.${name} != ""
  ) (lib.attrNames activationScripts);
in
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



  system.nixos-init.enable = true;

  assertions = [
    {
      assertion = !config.system.nixos-init.enable || offenders == [ ];
      message = "activationScripts skipped by nixos-init at boot (apply at switch only, state lost on reboot): "
        + lib.concatStringsSep ", " offenders;
    }
  ];
}
