{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
    };
  };
  programs.virt-manager.enable = true;
  users.users.lwb.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    dnsmasq
  ];
}
