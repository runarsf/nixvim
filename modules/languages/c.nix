{
  config,
  lib,
  ...
}:
lib.utils.mkLanguageModule config "c" {
  plugins = {
    lsp.servers = {
      clangd.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft = {
        c = [ "clang-format" ];
        cpp = [ "clang-format" ];
      };
    };

    clangd-extensions.enable = true;
  };
}
