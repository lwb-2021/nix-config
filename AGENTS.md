# AGENTS.md

## Language

- Communicate in **Simplified Chinese**.
- Code and comments in **English**.

## Repo overview

Single-user (`lwb`), single-machine (`x86_64-linux`) NixOS flake undergoing refactoring — avoid rigid assumptions.

- **Entry**: `flake.nix` → `flake-file.nix` — `inputs.import-tree ./modules` auto-imports every `.nix` file under `modules/`; there is no manual import list.
- **Aspects**: `modules/aspects/` — feature bundles (`base`, `desktop`, `development`, `networking`, `optim`, `persistence`, `theming`). Each defines `flake.aspects.<name>` with a `nixos` and/or `hm` part; machine configs compose them.
- **Machines**: `modules/machines/<host>/default.nix` — defines `nixosConfigurations` and `homeConfigurations` by listing aspects plus host-specific modules.
- **OS config**: `os/<host>/` — hardware, devices, software, boot. `os/universal/` holds pieces shared across hosts.
- **Legacy module tree**: `modules-leagcy/` — older OS/HM modules, still pulled in by `modules/machines/lwb`.
- **Secrets**: `secrets/lwb/` (sops-nix, age key paths differ for OS vs HM).
- **Services**: `services/` (openlist, postgresql).
- **Utils** (repo-local): `utils/` — scanning/import helpers；`home/utils/` — mail helper.
- **Custom options**: `collections.agent.enable`, `desktop.enable` toggle feature bundles；`data.persistence.*` / `data.local.*` / `data.sync.*` control impermanence.

## Refactoring in progress

- **`home/programs-old/`** — legacy home-manager program configs, migrating into `modules/aspects/`. Prefer adding new program configs to the relevant aspect.
- **`home/data/`** — declarative persistence data layer, consumed by `modules/aspects/persistence`.
- Shell convention and other incidental choices are not stable — check the current config rather than assuming.

## Critical constraints

- **`/` and `/home` are tmpfs** — no files written directly to `~/.xxx`, `~/.config/`, etc. survive reboot.
- **Never modify `/nix/store`** — edit Nix declarations in `~/Configurations` and rebuild.
- **Never download/run install scripts** — add to Nix config or use a devShell.
- **`hardware-configuration.nix` is auto-generated** — do not edit manually.

## Commands

```sh
# Rebuild and activate. Both build the toplevel with `nom build`, register it
# as the system generation with `nix-env --set`, then run
# switch-to-configuration. `apply` also bumps the dotfiles input.
just apply         # update-dots + switch
just switch        # switch only

# Update flake lock
just update        # nix flake update

# Temporary package (not persisted)
nix run nixpkgs#<pkg> -- <args>

# Backups
restic-home-data snapshots
restic-home-data restore latest
```

## Persistence

Paths are preserved via `preservation.preserveAt` (`modules/aspects/persistence`), driven by the `data.persistence.*` / `data.local.*` options declared per HM module.

| Path | Btrfs subvol | Persistence strategy |
|---|---|---|
| `/data/persistence` | `@data` | Preserved state — survives reboot |
| `/data/local` | `@data` | Local state (caches, Steam) — survives but recyclable |
| `/data/persistence/system/...` | `@data` | OS-level (SSH keys, machine-id, NM connections) |

`/etc` is an overlayfs whose upper layer lives in the tmpfs root, so nothing under `/etc` survives unless preserved above.

## Secrets (sops-nix)

- **OS key**: `/data/persistence/keys.txt`
- **HM key**: `~/.config/sops/age/keys.txt`
- **Sops files**: `secrets/lwb/files/{os,home}.yaml`
- Add new secrets in both `.sops.yaml` (creation rules) and the corresponding `secrets/lwb/{os,home}.nix`.

## Boot

- Limine (EFI) with secure boot and auto-enrolled keys; `/boot` is btrfs `@boot`, `/boot/efi` the shared ESP (automounted on demand).
- Kernel parameters live in `boot.kernelParams` across the optim/persistence aspects.
- Dual-boot entry for Ubuntu is declared via `boot.loader.limine.extraEntries` in `os/universal/bootloader.nix`.

## Other facts

- **nixpkgs mirror**: `mirrors.cernet.edu.cn` (CERNET). **GOPROXY**: `goproxy.cn`.
- **rclone**: crypt → onedrive + jianguoyun (webdav)；mount at `~/Cloud`.
- **syncthing**: phone + encrypted backup target.
- **restic**: local backups to `/data/backup/`, compressed, `--keep-last 4`.
- **Many TODO comments** — fix by editing Nix declarations, not dotfiles.
