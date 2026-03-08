{ pkgs, ... }:
pkgs.python3.withPackages (
  ps: with ps; [
    pandas
    matplotlib
    numpy

    requests
    beautifulsoup4
    lxml

    tabulate

    ipython
    ipykernel
  ]
)
