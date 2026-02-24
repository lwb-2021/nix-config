{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tesseract
    ocrmypdf

    readest
  ];
}
