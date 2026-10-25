{ config, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = true; # false

    powerManagement.finegrained = true; # false

    open = true;

    nvidiaSettings = false;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Removes the dGPU's HDMI/DP audio function so the GPU can reach D3cold and
  # power off when idle (snd_hda_intel otherwise pins it at power/control=on,
  # and nixpkgs only strips these on kernels older than 5.5). Trade-off: HDMI/DP
  # audio output stops working; built-in speakers are unaffected.
  # Disabled for now - decide whether the idle power saving is worth the audio.
  # services.udev.extraRules = ''
  #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"
  # '';
}
