{ config, ... }:
{
  programs.zoxide = {
    enable = true;

  };
  data.local.directories = [
    ".config/zoxide" # TODO: maybe sync
  ];
}
