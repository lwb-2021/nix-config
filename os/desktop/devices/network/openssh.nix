{ ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = [ "lwb" ];
      UseDns = true;
      X11Forwarding = false;
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
}
