{ ... }:
{
  programs.pandoc = {
    enable = true;
    defaults = {
      pdf-engine = "xelatex";
      variables = {
        mainfont = "Source Han Sans SC";
      };

    };
  };
}
