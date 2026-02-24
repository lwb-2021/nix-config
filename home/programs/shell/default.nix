{
  pkgs,
  ...
}:
let
  plug = name: {
    inherit name;
    src = pkgs.fishPlugins.${name}.src;
  };
in
{
  home.packages = with pkgs; [ grc ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings

      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';

    shellInit = ''
      test ! -e "$HOME/.x-cmd.root/local/data/fish/rc.fish" || source "$HOME/.x-cmd.root/local/data/fish/rc.fish"
    '';
    shellAliases = {
    };
    shellAbbrs = {
      cd = "z";
    };
    functions = {
      retry = ''
        while true
            $argv
            if test $status -eq 0
                break
            end
        end
      '';
    };
    plugins = [
      (plug "fzf-fish")
      (plug "sponge")
      (plug "grc")
      (plug "done")
    ];
  };
  programs.bash = {
    enable = true;
    historyControl = [ "ignorespace" ];
  };
  data.persistence = {
    files = [
      {
        file = ".local/share/fish/fish_history";
        method = "symlink";
      }
    ];
  };
}
