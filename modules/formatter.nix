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

    extraPackages = with pkgs; [nodePackages.prettier-plugin-solidity];

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
          solidity = {
            __unkeyed-1 = "prettier-solidity";
            __unkeyed-2 = "prettierd";
            stop_after_first = true;
          };
          _ = ["trim_whitespace"];
        };
        # https://github.com/stevearc/conform.nvim/blob/master/doc/formatter_options.md
        formatters = {
          shellcheck.command = lib.getExe pkgs.shellcheck;
          shellharden.command = lib.getExe pkgs.shellharden;
          shfmt.command = lib.getExe pkgs.shfmt;
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
          # This doesn't actually work...
          prettier-solidity.command =
            lib.getExe pkgs.nodePackages.prettier + " --write --plugin=prettier-plugin-solidity";
        };
      };
    };
  };
}
