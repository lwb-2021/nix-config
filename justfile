set shell := ["nu", "-c"]

current-hostname := shell("hostname")

default:
  @just --list

install hostname:
  # TODO: disko


apply: update-dots (switch-host current-hostname)
  echo "OK"

switch: write-flake (switch-host current-hostname)

checkhealth: 
  nix run github:DeterminateSystems/flake-checker --quiet


write-flake: 
  nix run ".#write-flake"

update: write-flake
  nix flake update

update-dots: write-flake
  nix flake update dotfiles




switch-host hostname: 
  #!/usr/bin/env nu
  print "\n{{ style("bold", "→ Running switch") }}\n"
  let out = nom build ".#nixosConfigurations.{{hostname}}.config.system.build.toplevel" --no-link --print-out-paths --keep-going

  sudo /run/current-system/sw/bin/nix-env -p /nix/var/nix/profiles/system --set $out

  sudo $"($out)/bin/switch-to-configuration" switch
