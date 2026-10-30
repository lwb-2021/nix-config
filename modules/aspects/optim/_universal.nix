{ config, lib, ... }: {
  system.etc.overlay = {
    enable = true;
  };
  services.userborn = {
    enable = true;
  };

  boot.kernelParams = [ "overlay.index=off" ];

  system.nixos-init.enable = true;

  assertions =
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
    [
      {
        assertion = !config.system.nixos-init.enable || offenders == [ ];
        message =
          "activationScripts skipped by nixos-init at boot (apply at switch only, state lost on reboot): "
          + lib.concatStringsSep ", " offenders;
      }
    ];

}
