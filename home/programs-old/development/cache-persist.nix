{ ... }:
{
  data.local.directories = [
    ".cargo"
    ".android" # TODO

    ".local/share/direnv" # TODO

    ".config/.android" # TODO
  ];
  data.persistence.files = [
    ".gitconfig" # TODO
  ];
}
