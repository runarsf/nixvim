{
  config,
  lib,
  ...
}:
lib.utils.mkLanguageModule config "web" {
  plugins = {
    lsp.servers = {
      ts_ls.enable = true;
      cssls.enable = true;
      eslint.enable = true;
      html.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft = rec {
        javascript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
        typescript = javascript;
        html = ["htmlbeautifier"];
        css = ["stylelint"];
      };
    };
  };
}
