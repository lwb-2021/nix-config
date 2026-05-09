{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zotero
  ];
  # TODO
  data.local.directories = [
    ".local/share/Zotero"
  ];
}
