{ ... }: {
  flake.aspects.networking = {
    nixos = { config, lib, ... }: {
      networking = {
        wireless.iwd = {
          enable = lib.mkDefault (
            lib.any (
              c: (c.sub_class.name or "") == "WLAN controller"
            ) config.hardware.facter.report.hardware.network_controller
          );
        };

        dhcpcd = {
          allowInterfaces = lib.flatten (
            map (c: c.unix_device_names) config.hardware.facter.report.hardware.network_controller
          );
          extraConfig = "waitip 4";
        };

        nftables = {
          enable = true;
        };
      };
      # preservation.preserveAt."/data/persistence/system".directories = [ "/var/lib/iwd" ];

    };
    hm = { };
  };
}
