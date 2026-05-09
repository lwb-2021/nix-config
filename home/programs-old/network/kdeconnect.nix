{ ... }:
{
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  data.persistence.directories = [
    ".config/kdeconnect" # TODO
  ];
}
