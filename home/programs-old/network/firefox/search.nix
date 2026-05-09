{ pkgs, ... }:
{

  default = "bing";
  engines = {
    nix-packages = {
      name = "Nix Packages";
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
            {
              name = "channel";
              value = "unstable";
            }
          ];
        }
      ];

      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = [ "@np" ];
    };

    nixos-wiki = {
      name = "NixOS Wiki";
      urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
      iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
      definedAliases = [ "@nw" ];
    };

    github = {
      name = "Github";
      urls = [
        {
          template = "https://github.com/search?q={searchTerms}";
        }
      ];
      iconMapObj."16" = "https://github.com/favicon.ico";
      definedAliases = [ "@github" ];
    };
  };
}
