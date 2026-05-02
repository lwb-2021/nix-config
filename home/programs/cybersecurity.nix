{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Crypto
    sage

    # Web
    nmap
    burpsuite
    exploitdb

    # Reverse
    gdb
    ghidra

    # Misc
    _010editor
    cyberchef
    stegsolve
    wireshark
  ];
}
