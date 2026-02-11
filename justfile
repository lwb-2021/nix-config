set shell := ["fish", "-c"]

default:
  @just --list

install hostname:
  # TODO: disko
update:
  nix flake update



switch:
  nh os switch .
