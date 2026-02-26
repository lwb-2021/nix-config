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
          ".config/dconf" # TODO

          ".cache/fontconfig"
          ".cache/mesa_shader_cache"
          ".cache/nix"
          ".cache/nvidia"

          ".local/share/icons/hicolor" # TODO

          "Workspace"

        ]
        (lib.mkIf (params ? osConfig && params.osConfig.programs.steam.enable) [
          ".steam"
          ".local/share/Steam"

          ".local/share/Thrive" # TODO
          ".local/share/Mindustry" # TODO
        ])

        (lib.mkIf (params ? osConfig && params.osConfig.services.sunshine.enable) [
          ".config/sunshine" # TODO
        ])

        (lib.mkIf (params ? osConfig && params.osConfig.virtualisation.waydroid.enable) [
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
