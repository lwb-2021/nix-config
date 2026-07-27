{ config, pkgs, ... }:
{
  services.ssh-agent = {
    enable = true;
  };
  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/config.dynamic" ];
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
      "github" = {
        host = "github.com";
        user = "git";
        addKeysToAgent = "10m";
        identityFile = config.sops.secrets."ssh/keys/github".path;
      };
    };
  };
  data.persistence.files = [
    {
      file = ".ssh/known_hosts";
      method = "symlink";
    }
    ".ssh/config.dynamic"
  ];
  home.sessionVariables = {
    SSH_ASKPASS = pkgs.writeShellScript "ssh-askpass" ''
      #!/usr/bin/env bash
      prompt="$1"

      PINENTRY="${config.services.gpg-agent.pinentry.package}/bin/pinentry"

      save_to_pass() {
          local store_path="$1"
          local value="$2"
          if [[ -n "$value" && -n "$store_path" ]] && \
             command -v pass >/dev/null 2>&1; then
              echo "$value" | pass insert --force "$store_path" >/dev/null 2>&1
          fi
      }

      ask_save() {
          local desc="Saved passwords will be stored in pass (SSH/Passwords/...)."
          if [ -x "$PINENTRY" ] && \
             { [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; }; then
              local result
              result=$(printf 'SETDESC %s\nSETOK Save\nSETCANCEL Skip\nCONFIRM\nBYE\n' "$desc" |
                       "$PINENTRY" 2>/dev/null)
              # CONFIRM returns OK (confirmed) or ERR (cancelled); check no ERR line
              ! echo "$result" | grep -q "^ERR "
          else
              read -r -p "Save this password to pass store? [y/N] " reply </dev/tty
              echo >&2
              [[ "$reply" =~ ^[Yy] ]]
          fi
      }

      get_pass() {
          local desc="$1"
          if [ -x "$PINENTRY" ] && \
             { [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; }; then
              local result
              result=$(printf 'SETPROMPT Password:\nSETDESC %s\nGETPIN\nBYE\n' "$desc" |
                       "$PINENTRY" 2>/dev/null)
              local rc=$?
              [ $rc -ne 0 ] && return 1
              local pass
              pass=$(echo "$result" | sed -n 's/^D //p')
              [ -n "$pass" ] && echo "$pass" || return 1
          else
              read -s -p "$desc" pass
              echo >&2
              [ -n "$pass" ] && echo "$pass" || return 1
          fi
      }

      if echo "$prompt" | grep -qi "passphrase"; then
          # Key passphrase prompt
          # Format: "Enter passphrase for key '/path/to/key': "
          key=$(basename "$prompt" | tr -d "'" | tr -d ":" | tr -d " ")
          store_path="SSH/Passphrases/$key"
          pass=$(pass show "$store_path" 2>/dev/null)
          if [[ -z "$pass" ]]; then
              pass=$(get_pass "$prompt") || exit 1
              ask_save && save_to_pass "$store_path" "$pass"
          fi
          printf "%s" "$pass"
      else
          # Password prompt
          # Format: "user@host's password: " (from sshconnect2.c)
          host=$(echo "$prompt" | sed -n "s/^\(.*\)'s password.*$/\1/p")
          if [[ -n "$host" ]]; then
              store_path="SSH/Passwords/$host"
              pass=$(pass show "$store_path" 2>/dev/null)
          fi
          if [[ -z "$pass" ]]; then
              pass=$(get_pass "$prompt") || exit 1
              if [[ -n "$host" ]]; then
                  ask_save && save_to_pass "$store_path" "$pass"
              fi
          fi
          printf "%s" "$pass"
      fi
    '';
    SSH_ASKPASS_REQUIRE = "force";
  };
}
