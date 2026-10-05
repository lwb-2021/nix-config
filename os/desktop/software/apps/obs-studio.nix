{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = pkgs.noCuda.obs-studio;
    enableVirtualCamera = true;
    plugins = with pkgs.noCuda.obs-studio-plugins; [
      obs-backgroundremoval
    ];
  };
}
