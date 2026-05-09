{ ... }:
{
  programs.zoxide = {
    enable = true;
  };
  data.persistence.directories = [
    ".local/share/zoxide"
  ];
}
