{ pkgs, ... }:
{
  xdg = {
    configFile = {
      "Thunar/uca.xml".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <actions>
        <action>
        	<icon>utilities-terminal</icon>
        	<name>在此处打开终端</name>
        	<submenu></submenu>
        	<unique-id>1745653556796274-1</unique-id>
        	<command>wezterm start --cwd %f</command>
        	<description>在此处打开终端</description>
        	<range></range>
        	<patterns>*</patterns>
        	<startup-notify/>
        	<directories/>
        </action>
        <action>
        	<icon>nvim</icon>
        	<name>在Neovide中打开</name>
        	<submenu></submenu>
        	<unique-id>1767257345980536-1</unique-id>
        	<command>bash -c &quot;cd %f &amp; neovide&quot;</command>
        	<description></description>
        	<range>*</range>
        	<patterns>*</patterns>
        	<startup-notify/>
        	<directories/>
        </action>
        <action>
        	<icon>nvim</icon>
        	<name>编辑</name>
        	<submenu></submenu>
        	<unique-id>1771910165033862-1</unique-id>
        	<command>neovide %f</command>
        	<description></description>
        	<range>*</range>
        	<patterns>*</patterns>
        	<other-files/>
        	<text-files/>
        </action>
        </actions>
      ''; # TODO: toXML
    };
    dataFile = {
      "Thunar/sendto/kdeconnect-thunar.desktop".source =
        "${pkgs.kdePackages.kdeconnect-kde}/share/Thunar/sendto/kdeconnect-thunar.desktop";
    };
  };
  data.local.directories = [
    ".cache/thumbnails"
  ];

}
