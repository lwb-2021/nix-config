{ lib, ... }@params:
{
  data = {
    persistence = {
      directories = [

      ];
      files = [ ];
    };
    local = {
      directories = lib.mkMerge [
        [
          ".cache/fontconfig"
          ".cache/mesa_shader_cache"
          ".cache/nix"
          ".cache/nvidia"

        ]
        (lib.mkIf (params ? osConfig && params.osConfig.programs.steam.enable) [
          ".steam"
          ".local/share/Steam"
        ])
      ];
      files = [ ];
    };
  };
}
