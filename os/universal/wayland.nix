{ pkgs, inputs, ... }:
{

  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs.noctalia-greeter = {
    enable = true;
  };

  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  security.polkit = {
    enable = true;
  };
  security.soteria.enable = true;

  # Thunar

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
    ];
  };
  programs.xfconf.enable = true;
  services.gvfs = {
    enable = true;
  };
  services.tumbler.enable = true;
  environment.systemPackages = with pkgs; [
    xfce4-exo
    xarchiver

    ffmpegthumbnailer
  ];

}
