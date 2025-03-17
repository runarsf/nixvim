{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  options.modules.formatter.enable = lib.mkEnableOption "formatter";

  config = lib.mkIf config.modules.formatter.enable {
    keymaps = [
      {
        key = "<leader>f";
        action = "<CMD>lua require'conform'.format()<CR>";
        options.desc = "Format active file";
      }
      {
        key = "<leader>F";
        action = "<CMD>w | sleep 200m | lua require'conform'.format()<CR>";
        options.desc = "Write and format active file";
      }
    ];

    plugins.conform-nvim = {
      enable = true;
      # https://github.com/stevearc/conform.nvim?tab=readme-ov-file#options
      settings = {
        # `:help conform-formatters`
        formatters_by_ft = {
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          nix = {
            # TODO Remove nixfmt when alejandra supports pipe operator: https://github.com/kamadorueda/alejandra/issues/436
            __unkeyed-2 = "nixfmt";
            __unkeyed-1 = "alejandra";
            stop_after_first = true;
          };
          dart = ["dart_format"];
          lua = ["stylua"];
          c = ["clang-format"];
          cpp = ["clang-format"];
          python = [
            "isort"
            "ruff_fix"
            "ruff_format"
          ];
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          typescript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          typst = ["typstfmt"];
          cs = {
            __unkeyed-1 = "uncrustify";
            __unkeyed-2 = "csharpier";
            stop_after_first = true;
          };
          html = ["htmlbeautifier"];
          css = ["stylelint"];
          go = ["goimports" "gofmt"];
          http = ["kulala-fmt"];
          nu = ["nufmt"];
          _ = ["trim_whitespace"];
        };
        # https://github.com/stevearc/conform.nvim/blob/master/doc/formatter_options.md
        formatters = {
          shellcheck.command = lib.getExe pkgs.shellcheck;
          shellharden.command = lib.getExe pkgs.shellharden;
          nufmt.command = lib.getExe pkgs.nufmt;
          shfmt.command = lib.getExe pkgs.shfmt;
          kulala-fmt.command = lib.getExe pkgs.kulala-fmt;
          goimports.command = lib.getExe' pkgs.gotools "goimports";
          alejandra = {
            command = lib.getExe pkgs.alejandra;
            args = [
              "--quiet"
              "-"
            ];
          };
          nixfmt.command =
            lib.getExe
            inputs.nixfmt.packages.${pkgs.system}.default;
        };
      };
    };
  };
}
