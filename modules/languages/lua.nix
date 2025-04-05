{
  config,
  lib,
  pkgs,
  helpers,
  ...
}:
lib.utils.mkLanguageModule config "lua" {
  plugins = {
    lsp.servers = {
      lua_ls.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.lua = [ "stylua" ];

      formatters.stylua = {
        command = lib.getExe pkgs.stylua;
        # args = ["--indent-width" (builtins.toString config.opts.shiftwidth) "--stdin-filepath" "$FILENAME" "-"];
        # cwd = helpers.mkRaw ''require("conform.util").root_file({ ".editorconfig", "package.json", ".stylua.toml" })'';
      };
    };
  };
}
