{ pkgs, ... }:
{
  services.kdeconnect = {
    enable = true;
    package = pkgs.valent;
    indicator = true;
  };
  xdg.dataFile = {
    "Thunar/sendto/send-to-phone.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Send to phone
      Exec=valent %F
      Name[zh_CN]=发送到手机
    '';
  };

  data.persistence.directories = [
    ".config/kdeconnect" # TODO remove
    ".config/valent"
  ];
}
