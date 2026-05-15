set shell := ["fish", "-c"]

default:
  @just --list

install hostname:
  # TODO: disko
update:
  nix flake update



switch:
  nh os switch .

# For agent use: apply changes with polkit
apply:
  nh os switch -e pkexec

