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
    };

    conform-nvim.settings = {
      formatters_by_ft = rec {
        javascript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
        typescript = javascript;
        html = ["deno_fmt"];
        css = ["deno_fmt"];
      };

      formatters = {
        prettier = {
          command = lib.getExe pkgs.nodePackages.prettier;
          # args = ["--stdin-filepath" "$FILENAME"];
        };
        deno_fmt = {
          command = lib.getExe pkgs.deno;
          # args = ["fmt" "-"];
        };
      };
    };
  };
}
