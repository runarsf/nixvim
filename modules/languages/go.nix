{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "go" {
  plugins = {
    lsp.servers = {
      gopls.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.go = ["goimports" "gofmt"];

      formatters.goimports.command = lib.getExe' pkgs.gotools "goimports";
    };

    dap-go.enable = true;
  };
}
