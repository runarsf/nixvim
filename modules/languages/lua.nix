{
  config,
  lib,
  ...
}:
lib.utils.mkLanguageModule config "lua" {
  plugins = {
    lsp.servers = {
      lua_ls.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.lua = ["stylua"];
    };
  };
}
