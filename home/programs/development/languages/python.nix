{
  pkgs,
  ...
}:
{
  home.packages = [
    (import ./python-pkg.nix pkgs)
  ];
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
