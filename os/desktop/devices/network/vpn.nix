{ config, ... }:
{
  services.zerotierone = {
    # enable = true;
    joinNetworks = [
      "6ab565387a253314"
    ];

  };
  services.easytier = {
    enable = true;
    instances = {
      default = {
        enable = true;
        settings = {
          peers = [
            "udp://ramon2009.dpdns.org:11010"
            "udp://ah.nkbpal.cn:11010"
          ];
          network_name = "722bf611-62c9-4b08-9128-1eff0b194b63";
          ipv4 = "10.126.126.1/24";
        };
        environmentFiles = [
          config.sops.secrets."easytier/default/secret-env".path
        ];
      };
    };
  };

}
