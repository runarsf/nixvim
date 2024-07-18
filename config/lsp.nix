{ lib, pkgs, ... }:

{
  keymaps = [
    {
      key = "<M-CR>";
      action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
      mode = [ "i" "n" ];
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

  # TODO hover and goto binds: https://nix-community.github.io/nixvim/plugins/lsp/keymaps/index.html
  # TODO Native lsp: https://github.com/akinsho/flutter-tools.nvim?tab=readme-ov-file#new-to-neovims-lsp-client
  plugins = {
    lspkind.enable = true;
    lsp = {
      enable = true;
      servers = lib.enable [
        "tsserver"
        "bashls"
        "dartls" # FIXME dartls sends a notification every time it analyzes, which is every character typed...
        "csharp-ls"
        "clangd"
        "cssls"
        "lua-ls"
        "eslint"
        "hls"
        "html"
        "jsonls"
        "nil-ls"
        "ruff"
        "tailwindcss"
        "typst-lsp"
        "yamlls"
        "docker-compose-language-service"
      ] // {
        # FIXME Autostart ruff for files that exist on disk
        ruff.autostart = false;
        rust-analyzer = {
          enable = false; # Handled by rustacean
          installCargo = true;
          installRustc = true;
        };
      };
    };
  };

  # extraPlugins = with pkgs.vimPlugins; [
  #   {
  #     plugin = lsp_signature-nvim;
  #     config = ''lua require("lsp_signature").setup()'';
  #   }
  # ];
}
