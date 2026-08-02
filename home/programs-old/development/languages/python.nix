{ pkgs, ... }:
{
  programs.python = {
    enable = true;
    extraPackages = with pkgs.python3Packages; [
      # Data
      pandas
      matplotlib
      numpy

      # ML
      scikit-learn

      # HTML
      requests
      beautifulsoup4
      lxml

      # Web
      scapy

      # PWN
      pwntools

      tqdm

      ipython
      ipykernel
    ];
  };

  programs.uv = {
    enable = true;
    settings = {
      python-downloads = "never";
      pip.index-url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/";
    };
  };
  xdg.configFile."pip/pip.conf".text = ''
    [global]
    index-url = https://pypi.tuna.tsinghua.edu.cn/simple
  '';
}
