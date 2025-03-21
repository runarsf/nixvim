{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "nushell" {
  plugins = {
    lsp.servers = {
      nushell.enable = true;
    };

    # conform-nvim.settings = {
    #   formatters_by_ft.nu = ["nufmt"];
    #
    #   formatters.nufmt.command = lib.getExe pkgs.nufmt;
    # };
  };
}
