_:

{
  # TODO hover and goto binds: https://nix-community.github.io/nixvim/plugins/lsp/keymaps/index.html
  plugins = {
    lspkind.enable = true;
    lsp = {
      enable = true;
      servers = {
        tsserver.enable = true;
        bashls.enable = true;
        clangd.enable = true;
        cssls.enable = true;
        lua-ls.enable = true;
        eslint.enable = true;
        hls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        nil_ls.enable = true;
        ruff.enable = true;
        # FIXME Autostart ruff for files that exist on disk
        ruff.autostart = false;
        tailwindcss.enable = true;
        typst-lsp.enable = true;
        terraformls.enable = true;
        yamlls.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
      };
    };
  };
}
