{ lib, ... }:

{
  # TODO hover and goto binds: https://nix-community.github.io/nixvim/plugins/lsp/keymaps/index.html
  plugins = {
    lspkind.enable = true;
    lsp = {
      enable = true;
      servers = lib.enable [
        "tsserver"
        "bashls"
        "clangd"
        "cssls"
        "lua-ls"
        "eslint"
        "hls"
        "html"
        "jsonls"
        "nil_ls"
        "ruff"
        "tailwindcss"
        "typst-lsp"
        "terraformls"
        "yamlls"
      ] // {
        # FIXME Autostart ruff for files that exist on disk
        ruff.autostart = false;
        rust-analyzer = {
          enable = true;
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
