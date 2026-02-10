{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    libreoffice-fresh
    /*
      (wpsoffice-cn.overrideAttrs {
        postInstall = ''
          for i in $out/share/applications/*;do
            echo Exec=\'env XMODIFIERS="@im=fcitx" GTK_IM_MODULE="fcitx" QT_IM_MODULE="fcitx" SDL_IM_MODULE=fcitx GLFW_IM_MODULE=ibus QT_SCALE_FACTOR=1.5 $(sed -n 's/^Exec=//p' $i)\' >> $i
            sed -i '0,/^Exec=/ {/^Exec=/d}' $i
          done
        '';
      })
    */
  ];

}
