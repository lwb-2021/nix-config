{ pkgs, ... }:
{
  services.wl-clip-persist = {
    enable = true;
    clipboardType = "both";
  };
  home.packages = with pkgs; [ wl-clipboard-rs ];

}
