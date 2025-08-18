{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "nix" {
  plugins = {
    hmts.enable = true;

    lsp.servers = {
      statix.enable = true;
      nixd = {
        enable = true;
        settings = let
          flakeExpr =
            # nix
            ''(builtins.getFlake "${inputs.self}")'';
          systemExpr =
            # nix
            ''''${builtins.currentSystem}'';
        in {
          formatting.command = ["nix fmt"];

          nixpkgs.expr =
            # nix
            "import ${flakeExpr}.inputs.nixpkgs { system = ${systemExpr}; }";

          options = {
            nixvim.expr =
              # nix
              "${flakeExpr}.packages.${systemExpr}.nvim.options";

            # TODO: make nixvim not rely on my dotfiles for these options

            nixos.expr =
              # nix
              "${flakeExpr}.inputs.dotfiles.nixosConfigurations.runix.options";

            home-manager.expr =
              # nix
              "${flakeExpr}.inputs.dotfiles.homeConfigurations.runar.options";
          };
        };
      };
    };

    lint = {
      lintersByFt.nix = ["deadnix"];

      linters.deadnix.cmd = lib.getExe pkgs.deadnix;
    };

    conform-nvim.settings = {
      formatters_by_ft.nix = ["alejandra"];

      formatters.alejandra = {
        command = lib.getExe pkgs.alejandra;
        args = ["--quiet" "-"];
      };
    };
  };
}
