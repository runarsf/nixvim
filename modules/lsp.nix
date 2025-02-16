{
  config,
  inputs,
  lib,
  pkgs,
  utils,
  ...
}: {
  options.modules.lsp.enable = lib.mkEnableOption "lsp";

  config = lib.mkIf config.modules.lsp.enable {
    keymaps = [
      {
        key = "<C-.>";
        action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
        mode = ["i" "n"];
        options.desc = "(lsp) Code actions";
      }
      {
        key = "<C-.>";
        action = "<CMD>lua vim.lsp.buf.range_code_action()<CR>";
        mode = ["x"];
        options.desc = "(lsp) Code actions";
      }
      {
        key = "gd";
        action = "<CMD>lua vim.lsp.buf.definition()<CR>";
        mode = ["n"];
        options.desc = "(lsp) Go to definition";
      }
      {
        key = "gD";
        action = "<CMD>lua vim.lsp.buf.declaration()<CR>";
        mode = ["n"];
        options.desc = "(lsp) Go to declaration";
      }
      {
        key = "gr";
        action = "<CMD>lua vim.lsp.buf.references()<CR>";
        mode = ["n"];
        options.desc = "(lsp) Go to references";
      }
      {
        key = "K";
        action = "<CMD>lua vim.lsp.buf.hover()<CR>";
        mode = ["n"];
        options.desc = "(lsp) Hover";
      }
      {
        key = "<leader>R";
        action = "<CMD>lua vim.lsp.buf.rename()<CR>";
        mode = ["n"];
        options.desc = "(lsp) Rename";
      }
      # {
      #   key = "<leader>h";
      #   # action = "<CMD>lua require('lspconfig').inlay_hint.enable(0, not require('lspconfig').inlay_hint.is_enabled())<CR>";
      #   action = "<CMD>InlayHintsToggle<CR>";
      #   options.desc = "Toggle inlay hints";
      # }
    ];

    extraPackages = with pkgs; [
      isort
      ruff
      stylua
      typstfmt
      uncrustify
      prettierd
    ];

    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;
        servers =
          utils.enable [
            "ts_ls"
            "bashls"
            "clangd"
            "cssls"
            "lua_ls"
            "eslint"
            "html"
            "jsonls"
            "tinymist"
            "yamlls"
            "docker_compose_language_service"
            # FIXME Autostart ruff for files that exist on disk
            "ruff"
          ]
          // {
            nil_ls = {
              enable = true;
              package = inputs.nil_ls.packages.${pkgs.system}.default;
            };
            # solidity_ls = {
            #   enable = true;
            #   package = pkgs.nodePackages.solidity-language-server;
            # };
            rust_analyzer = {
              enable = false; # Handled by rustacean
              installCargo = true;
              installRustc = true;
            };
            dartls = {
              enable = true;
              settings = {
                lineLength = 120;
                showTodos = true;
                updateImportsOnRename = true;
                enableSnippets = true;
              };
            };
            hls = {
              enable = true;
              installGhc = true;
            };
          };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      # {
      #   plugin = lsp_signature-nvim;
      #   config = ''lua require("lsp_signature").setup()'';
      # }
      # {
      #   plugin = inlay-hints;
      #   config = utils.luaToViml ''require("inlay-hints").setup({})'';
      # }
    ];
  };
}
