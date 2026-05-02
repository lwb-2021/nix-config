{ pkgs, ... }:
pkgs.python3.withPackages (
  ps: with ps; [

    # Data
    pandas
    matplotlib
    numpy

    # HTML
    requests
    beautifulsoup4
    lxml

    # Crypto
    pycryptodome
    gmpy2

    # Web
    scapy

    # PWN
    pwntools

    tabulate

    ipython
    ipykernel
  ]
)
