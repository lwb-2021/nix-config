{ lib, ... }@params:
{
  data = {
    persistence = {
      directories = [
        "Configurations"
      ];
      files = [ ];
    };
    local = {
      directories = lib.mkMerge [
        [
          ".pki/nssdb" # TODO

          ".cache/fontconfig"
          ".cache/mesa_shader_cache"
          ".cache/nix"
          ".cache/nvidia"
          ".cache/tealdeer" # TODO: move to tealdeer

          ".local/share/icons/hicolor" # TODO

          ".local/share/containers"

          "Workspace"

        ]
        (lib.mkIf (params.osConfig.programs.steam.enable or false) [
          ".steam"
          ".local/share/Steam"

          ".local/share/Thrive" # TODO
          ".local/share/Mindustry" # TODO
        ])

        (lib.mkIf (params.osConfig.services.sunshine.enable or false) [
          ".config/sunshine" # TODO
        ])

        (lib.mkIf (params.osConfig.virtualisation.waydroid.enable or false) [
          ".local/share/waydroid"
        ])

        # TODO
        [
          ".config/obsidian"
          ".config/obs-studio"
          ".config/unity3d"

          ".config/xarchiver"
          ".config/xfce4"
        ]
      ];
      files = [
        ".config/gtk-3.0/bookmarks" # TODO
      ];
    };
    sync = {
      folders = [
        "Configurations"
      ];
    };
  };
}
