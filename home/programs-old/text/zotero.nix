{ pkgs, ... }:
{
  # TODO
  home.packages = with pkgs.noCuda; [
    # zotero
  ];

  # TODO: wait for module
  data.local.directories = [
    ".local/share/Zotero"
  ];
}
