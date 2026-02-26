{
  pkgs,
  ...
}:
{
  # TODO
  data.local.directories = [ ".config/VSCodium" ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      userSettings = {

        "editor.acceptSuggestionOnEnter" = "smart";

        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = true;

        "editor.fontLigatures" = true;

        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.autoIndentOnPaste" = true;

        "files.autoSave" = "afterDelay";
        "files.autoGuessEncoding" = true;

        "files.readonlyInclude" = {
          "**/.cargo/registry/src/**/*.rs" = true;
          "**/.cargo/git/checkouts/**/*.rs" = true;
          "**/lib/rustlib/src/rust/library/**/*.rs" = true;
        };

        "terminal.integrated.defaultProfile.linux" = "fish";

        "window.dialogStyle" = "custom";

        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };

        # Git
        "github.gitProtocol" = "ssh";
        "gitblame.inlineMessageEnabled" = true;

        # Java

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
        "nix.serverSettings" = {
          "nixd" = {
            # "formatting": {
            #   "command": ["nixfmt"],
            # },
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"./.\").nixosConfigurations.lwb.options";
              };
              "home-manager" = {
                "expr" = "(builtins.getFlake \"./.\").homeConfigurations.lwb.options";
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
          adpyke.codesnap

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

          # Nix
          # bbenoist.nix

          # Completions and Linting
          ## No Language
          christian-kohler.path-intellisense

          ## Python
          ms-python.python
          # ms-python.vscode-pylance
          charliermarsh.ruff

          ## Rust
          rust-lang.rust-analyzer

          ## TOML
          tamasfe.even-better-toml

          ## TS & Vue
          vue.volar

          # AI
          github.copilot
          qwenlm.qwen-code-vscode-ide-companion

        ]
        ++ (with pkgs.open-vsx; [

          jeanp413.open-remote-ssh
        ])
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
