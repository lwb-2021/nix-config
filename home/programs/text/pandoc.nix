{
  config,
  pkgs,
  ...
}:
{
  programs.pandoc = {
    enable = true;
    defaults = {
      pdf-engine = "xelatex";
      filters = [
        "${config.home.homeDirectory}/.config/pandoc-filters/zotero.lua"
      ];
      variables = {
        mainfont = "Source Han Sans SC";
      };

    };
  };
  home.file = {
    ".config/pandoc-filters/zotero.lua".source = pkgs.fetchurl {
      url = "https://retorque.re/zotero-better-bibtex/exporting/zotero.lua";
      hash = "sha256-I0HLtoCNYY2Om2YOIUkZXsmakQtxhDMtiBlYDKUL6F0=";
    };
  };

}
