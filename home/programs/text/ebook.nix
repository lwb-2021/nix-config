{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tesseract
    ocrmypdf

    readest
  ];
  data.local.directories = [
    ".local/share/com.bilingify.readest"
    ".config/com.bilingify.readest"
  ];
}
