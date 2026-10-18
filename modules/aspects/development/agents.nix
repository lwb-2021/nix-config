{ ... }: {
  flake-file.inputs = {
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs = {
        nixpkgs.autoFollow = false;
        bun2nix.inputs.nixpkgs.autoFollow = false;
      };
    };
  };
  flake.aspects.development = {
    nixos = { };
    hm =
      { pkgs, inputs, ... }:
      {
        home.packages =
          with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
          [ dsh ] ++ (with pkgs; [ pnpm ]);
        data.persistence = {
          directories = [ ".dsh" ];
        };
        desktop.autostart.commands = [
          "systemd-run --user --collect --unit=dsh-web dsh web --no-open"
        ];

      };
  };
}
