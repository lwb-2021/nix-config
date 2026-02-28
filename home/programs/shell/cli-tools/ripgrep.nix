{ ... }:
{
  programs.ripgrep = {
    enable = true;
    package = null;
    arguments = [
      ""
    ];
  };
  programs.ripgrep-all = {
    enable = true;
  };
  data.local.directories = [
    ".cache/ripgrep"
    ".cache/ripgrep-all"
  ];
}
