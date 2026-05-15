# AGENTS.md

## Language

- Communicate in **Simplified Chinese**.
- Code and comments in **English**.

## Repo overview

Single-user (`lwb`), single-machine (`x86_64-linux`) NixOS flake undergoing refactoring — avoid rigid assumptions.

- **Entry**: `flake.nix` → `outputs/` — uses `utils` helpers (`mkImportAll`, `mkAttrsetFromPath`) to auto-import `.nix` files from directories (skipping `default.nix`).
- **Adding a `.nix` file** to a directory using `my-utils.mkImportAll ./.;` auto-imports it.
- **NixOS host**: `outputs/nixosConfigurations/default.nix` — binds HM as NixOS module.
- **Standalone HM**: `outputs/homeConfigurations/default.nix`.
- **Machine config**: `os/desktop/` — hardware, devices, software, boot.
- **OS modules**: `modules/os/`；**Universal modules**: `modules/universal/` (shared by OS + HM).
- **HM modules**: `modules/home/` — basic, collections, programs, stylix.
- **Secrets**: `secrets/lwb/` (sops-nix, age key paths differ for OS vs HM).
- **Services**: `services/` (openlist, postgresql).
- **Utils** (repo-local): `utils/` — scanning/import helpers；`home/utils/` — mail helper.
- **Custom options**: `collections.agent.enable`, `desktop.enable` toggle feature bundles；`data.persistence.*` / `data.local.*` / `data.sync.*` control impermanence.

## Refactoring in progress

- **`home/programs-old/`** — legacy, being migrated to `modules/home/programs/` and `modules/home/collections/`. Prefer adding new program configs in the new locations.
- **`home/data/`** — legacy impermanence data layer, being restructured.
- Shell convention and other incidental choices are not stable — check the current config rather than assuming.

## Critical constraints

- **`/` and `/home` are tmpfs** — no files written directly to `~/.xxx`, `~/.config/`, etc. survive reboot.
- **Never modify `/nix/store`** — edit Nix declarations in `~/Configurations` and rebuild.
- **Never download/run install scripts** — add to Nix config or use a devShell.
- **`hardware-configuration.nix` is auto-generated** — do not edit manually.

## Commands

```sh
# Apply changes (with polkit) — use this, not `just switch`
just apply         # nh os switch -e pkexec

# Update flake lock
just update        # nix flake update

# Temporary package (not persisted)
nix run nixpkgs#<pkg> -- <args>

# Backups
restic-home-data snapshots
restic-home-data restore latest
```

## Impermanence persistence

| Path | Btrfs subvol | Persistence strategy |
|---|---|---|
| `/data/persistence` | `@data` | HM impermanence mounts — survives reboot |
| `/data/local` | `@data` | Local state (caches, Steam) — survives but recyclable |
| `/data/persistence/system/...` | `@data` | OS-level (SSH keys, machine-id, NM connections) |

## Secrets (sops-nix)

- **OS key**: `/data/persistence/keys.txt`
- **HM key**: `~/.config/sops/age/keys.txt`
- **Sops files**: `secrets/lwb/files/{os,home}.yaml`
- Add new secrets in both `.sops.yaml` (creation rules) and the corresponding `secrets/lwb/{os,home}.nix`.

## Boot

- Limine + systemd-boot, UKI, secure boot with auto-enrolled keys.
- Dual-boot entry for Ubuntu.

## Other facts

- **nixpkgs mirror**: TUNA (primary), USTC (fallback). **GOPROXY**: `goproxy.cn`.
- **Stylix**: catppuccin mocha, GTK/Qt/fonts/cursor.
- **rclone**: crypt → onedrive + jianguoyun (webdav)；mount at `~/Cloud`.
- **syncthing**: phone + encrypted backup target.
- **restic**: local backups to `/data/backup/`, compressed, keep-last 4.
- **Many TODO comments** — fix by editing Nix declarations, not dotfiles.
