{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "json" {
  plugins = {
    lsp.servers = {
      jsonls.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.json = ["deno_fmt"];

      formatters.deno_fmt = {
        command = lib.getExe pkgs.deno;
        args = ["fmt" "$FILENAME"];
      };
    };
  };
}
