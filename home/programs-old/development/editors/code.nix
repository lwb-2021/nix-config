{
  lib,
  pkgs,
  ...
}:
{
  # TODO
  data.local.directories = [
    ".config/Code"
    ".vscode-shared" # VSCode shared storage
  ];
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    argvSettings = {
    };
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      userSettings = {
        "chat.disableAIFeatures" = true;

        "editor.acceptSuggestionOnEnter" = "smart";

        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = true;

        "editor.fontLigatures" = true;

        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.autoIndentOnPaste" = true;
        "editor.pasteAs.preferences" = [
          "text.pylance.reindent"
        ];

        "files.autoSave" = "afterDelay";
        "files.autoGuessEncoding" = true;

        "files.readonlyInclude" = {
          "**/.cargo/registry/src/**/*.rs" = true;
          "**/.cargo/git/checkouts/**/*.rs" = true;
          "**/lib/rustlib/src/rust/library/**/*.rs" = true;
        };

        "terminal.integrated.defaultProfile.linux" = "nu";
        "terminal.integrated.stickyScroll.ignoredCommands" = [
          "pi"
        ];

        "window.dialogStyle" = "custom";

        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };

        "remote.SSH.configFile" = "~/.ssh/config.dynamic";
        "remote.SSH.externalSSH_ASKPASS" = true;

        # Git
        "github.gitProtocol" = "ssh";
        "gitblame.inlineMessageEnabled" = true;

        # Python
        "python.languageServer" = "Pylance";
        "ty.disableLanguageServices" = true;
        "ty.path" = [ (lib.getExe pkgs.ty) ];

        # Java

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake (builtins.getEnv \"NH_FLAKE\")).nixosConfigurations.lwb.options";
              };
              "home-manager" = {
                "expr" = "(builtins.getFlake (builtins.getEnv \"NH_FLAKE\")).homeConfigurations.lwb.options";
              };
            };
          };
        };
      };
      extensions =
        with pkgs.vscode-marketplace;
        [
          # Functionality
          gruntfuggly.todo-tree
          formulahendry.code-runner
          ms-vscode-remote.remote-ssh
          formulahendry.acp-client

          # Edit
          usernamehw.errorlens
          asvetliakov.vscode-neovim
          formulahendry.auto-rename-tag
          ## File Supports
          ms-vscode.hexeditor

          # Git
          codezombiech.gitignore
          donjayamanne.githistory
          mhutchie.git-graph
          vivaxy.vscode-conventional-commits
          waderyan.gitblame

          github.vscode-github-actions

          # Nushell
          thenuprojectcontributors.vscode-nushell-lang

          # Completions and Linting
          ## No Language
          christian-kohler.path-intellisense

          # Justfile
          nefrob.vscode-just-syntax

          ## Python
          ms-python.python
          ms-python.vscode-pylance
          charliermarsh.ruff
          astral-sh.ty

          ## Rust
          rust-lang.rust-analyzer

          ## TOML
          tamasfe.even-better-toml

          ## TS & Vue
          vue.volar

          # AI
          github.copilot-chat

        ]
        ++ (with pkgs.vscode-extensions; [
          # Features
          mkhl.direnv
          ms-vscode.live-server
          alefragnani.project-manager

          # Languages
          ## Python
          ### Jupyter
          ms-toolsai.jupyter
          ms-toolsai.vscode-jupyter-slideshow
          ms-toolsai.vscode-jupyter-cell-tags
          ms-toolsai.jupyter-renderers
          ms-toolsai.jupyter-keymap

          github.vscode-pull-request-github

          ## Nix
          jnoortheen.nix-ide
        ]);
    };
  };
  home.packages = with pkgs; [
    nixfmt
  ];
}
