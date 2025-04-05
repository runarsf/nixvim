{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "rust" {
  plugins = {
    # lsp.servers = {
    #   rust_analyzer = {
    #     enable = false; # Handled by rustacean
    #     installCargo = true;
    #     installRustc = true;
    #   };
    # };
    rustaceanvim.enable = true;

    conform-nvim.settings = {
      formatters_by_ft.rust = [ "rustfmt" ];

      formatters.rustfmt.command = lib.getExe pkgs.rustfmt;
    };
  };
}
