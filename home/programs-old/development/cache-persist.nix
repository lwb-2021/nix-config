{ ... }:
{
  data.local.directories = [
    ".cargo"
    ".android" # TODO

    ".local/state" # TODO

    ".local/share/direnv" # TODO

    ".config/.android" # TODO
  ];
  data.persistence.files = [
    ".gitconfig" # TODO
  ];
}
