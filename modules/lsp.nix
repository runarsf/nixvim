{ config, lib, pkgs, utils, ... }:

{
  options.modules.lsp.enable = lib.mkEnableOption "lsp";

  config = lib.mkIf config.modules.lsp.enable {
    keymaps = [
      {
        key = "<C-.>";
        action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
        mode = [ "i" "n" ];
        options.desc = "(lsp) Code actions";
      }
      {
        key = "<C-.>";
        action = "<CMD>lua vim.lsp.buf.range_code_action()<CR>";
        mode = [ "x" ];
        options.desc = "(lsp) Code actions";
      }
      {
        key = "gd";
        action = "<CMD>lua vim.lsp.buf.definition()<CR>";
        mode = [ "n" ];
        options.desc = "(lsp) Go to definition";
      }
      {
        key = "gD";
        action = "<CMD>lua vim.lsp.buf.declaration()<CR>";
        mode = [ "n" ];
        options.desc = "(lsp) Go to declaration";
      }
      {
        key = "gr";
        action = "<CMD>lua vim.lsp.buf.references()<CR>";
        mode = [ "n" ];
        options.desc = "(lsp) Go to references";
      }
      {
        key = "K";
        action = "<CMD>lua vim.lsp.buf.hover()<CR>";
        mode = [ "n" ];
        options.desc = "(lsp) Hover";
      }
      {
        key = "<leader>R";
        action = "<CMD>lua vim.lsp.buf.rename()<CR>";
        mode = [ "n" ];
        options.desc = "(lsp) Rename";
      }
      {
        key = "<leader>h";
        # action = "<CMD>lua require('lspconfig').inlay_hint.enable(0, not require('lspconfig').inlay_hint.is_enabled())<CR>";
        action = "<CMD>InlayHintsToggle<CR>";
        options.desc = "Toggle inlay hints";
      }
    ];

    extraPackages = with pkgs; [
      csharpier
      isort
      ruff
      stylua
      typstfmt
      uncrustify
      prettierd
    ];

    plugins = {
      lspkind.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = utils.enable [
          "tsserver"
          "bashls"
          "csharp-ls"
          "clangd"
          "cssls"
          "lua-ls"
          "eslint"
          "hls"
          "html"
          "jsonls"
          "nil-ls"
          "tailwindcss"
          "typst-lsp"
          "yamlls"
          "docker-compose-language-service"
        ] // {
          # FIXME Autostart ruff for files that exist on disk
          ruff = {
            enable = true;
            autostart = false;
          };
          rust-analyzer = {
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
        };
      };
    };

    extraPlugins = with pkgs;
      [
        # {
        #   plugin = lsp_signature-nvim;
        #   config = ''lua require("lsp_signature").setup()'';
        # }
        {
          plugin = vimUtils.buildVimPlugin rec {
            name = "inlay-hints.nvim";
            src = fetchFromGitHub {
              owner = "MysticalDevil";
              repo = name;
              rev = "1d5bd49a43f8423bc56f5c95ebe8fe3f3b96ed58";
              hash = "sha256-E6+h9YIMRlot0umYchGYRr94bimBosunVyyvhmdwjIo=";
            };
          };
          config = utils.luaToViml ''require("inlay-hints").setup({})'';
        }
      ];
  };
}
