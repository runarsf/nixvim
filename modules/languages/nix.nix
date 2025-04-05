{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
lib.utils.mkLanguageModule config "nix" {
  plugins = {
    lsp.servers = {
      nixd = {
        enable = true;
        settings =
          let
            flakeExpr =
              # nix
              ''(builtins.getFlake "${inputs.self}")'';
            systemExpr =
              # nix
              ''''${builtins.currentSystem}'';
          in
          {
            formatting.command = [ "nix fmt" ];

            nixpkgs.expr =
              # nix
              "import ${flakeExpr}.inputs.nixpkgs { system = ${systemExpr}; }";

            options = {
              nixvim.expr =
                # nix
                "${flakeExpr}.packages.${systemExpr}.nvim.options";
            };
          };
      };
    };

    lint = {
      lintersByFt.nix = [
        "statix"
        "deadnix"
      ];
    };

    conform-nvim.settings = {
      formatters_by_ft.nix = [ "nixfmt" ];
      # formatters_by_ft.nix = {
      #   # TODO Remove nixfmt when alejandra supports pipe operator: https://github.com/kamadorueda/alejandra/issues/436
      #   __unkeyed-1 = "alejandra";
      #   __unkeyed-2 = "nixfmt";
      #   stop_after_first = true;
      # };

      formatters = {
        nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
        alejandra = {
          command = lib.getExe pkgs.alejandra;
        };
      };
    };

    hmts.enable = true;
  };
}
