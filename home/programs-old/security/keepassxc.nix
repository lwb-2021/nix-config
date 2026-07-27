{ pkgs, ... }:
{
  programs.keepassxc = {
    enable = true;
    settings = {
      General = {
        ConfigVersion = "2";
        MinimizeAfterUnlock = true;

      };
      Browser = {
        Enabled = true;
        UpdateBinaryPath = false;
        CustomProxyLocation = "/tmp";
      };
      GUI = {
        ApplicationTheme = "classic";
        CompactMode = true;
        MinimizeOnClose = true;
        MinimizeOnStartup = true;
        MinimizeToTray = true;
        ShowTrayIcon = true;
        TrayIconAppearance = "colorful";
      };
    };
  };
  xdg.autostart.entries = [
    "${pkgs.keepassxc}/share/applications/org.keepassxc.KeePassXC.desktop"
  ];
  data.persistence.directories = [
    ".cache/keepassxc"
  ];
}
