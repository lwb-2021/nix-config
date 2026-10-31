{ lib, pkgs, ... }:
{
  allowUnfreePredicate =
    pkg:
    (builtins.elem (lib.getName pkg) [

      "feishu"
      "libwemeetwrap"
      "wemeet"

      "p7zip"
      "unrar"

      #####
      "nvidia-x11"
      "nvidia-settings"


      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "xone-dongle-firmware"

      "zerotierone"

      "ttf-wps-fonts"
      "wpsoffice-cn"

      "pantum-driver"

      "obsidian"

      "tampermonkey"

      "vscode"
      "vscode-extension-ms-python-vscode-pylance"
      "vscode-extension-mhutchie-git-graph"
      "vscode-extension-ms-vscode-remote-remote-ssh"

      "intellij-idea"
      "drawio"

      "evafast"

      "windows-fonts"
    ] || (pkgs._cuda.lib.allowUnfreeCudaPredicate pkg));
  permittedInsecurePackages = [
  ];
  cudaSupport = true;
  packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

}
