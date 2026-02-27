{ config, pkgs, ... }:
{
  services.ssh-agent = {
    enable = true;
  };
  programs.ssh = {
    enable = true;
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
        addKeysToAgent = "1h";
        identityFile = config.sops.secrets."ssh/keys/github".path;
      };
    };
  };
  data.persistence.files = [
    {
      file = ".ssh/known_hosts";
      method = "symlink";
    }
  ];
  home.sessionVariables = {
    SSH_ASKPASS = pkgs.writeShellScript "ssh-askpass" ''
      #!/bin/bash
      key=$(basename "$1" | tr -d "'" | tr -d ":" | tr -d " ")
      pass=$(pass show "ssh/passphrases/$key" 2>/dev/null)
      if [ -z "$pass" ]; then
          if [ -n "$WAYLAND_DISPLAY" ]; then
              pass=$(zenity --entry --hide-text --text="请输入 SSH 密钥 $key 的密码：")
          else
              read -s -p $1 pass
              echo
          fi
      fi
      printf "%s" "$pass"
    '';
    SSH_ASKPASS_REQUIRE = "force";
  };
}
