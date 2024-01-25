_:

{
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
        ruff-lsp.enable = true;
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
