{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "haskell" {
  plugins = {
    lsp.servers = {
      hls = {
        enable = true;
        installGhc = true;
      };
    };

    conform-nvim.settings = {
      formatters_by_ft.haskell = ["ormolu"];

      formatters.ormolu.command = lib.getExe pkgs.ormolu;
    };
  };
}
