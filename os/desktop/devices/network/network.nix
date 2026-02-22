{ ... }:
{
  networking = {
    hostName = "lwb";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    nftables = {
      enable = true;
    };
  };
}
