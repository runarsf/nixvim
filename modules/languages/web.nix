{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "web" {
  plugins = {
    lsp.servers = {
      ts_ls.enable = true;
      cssls.enable = true;
      eslint.enable = true;
      html.enable = true;
      emmet_language_server.enable = true;
      tailwindcss.enable = true;
    };

    tailwind-tools.enable = true;

    conform-nvim.settings = {
      formatters_by_ft = rec {
        javascript = ["prettierd"];
        typescript = javascript;
        typescriptreact = javascript;

        html = javascript;
        htmlangular = javascript;

        css = javascript;
      };

      formatters.prettierd.command = lib.getExe pkgs.prettierd;
    };

    lint = {
      linters.eslint_d.cmd = lib.getExe pkgs.eslint_d;

      lintersByFt = rec {
        javascript = ["eslint_d"];
        typescript = javascript;
        typescriptreact = javascript;
      };
    };
  };

  extraPackages = with pkgs; [prettierd];
}
