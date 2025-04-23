{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "go" {
  extraPackages = with pkgs; [gotools];

  plugins = {
    lsp.servers = {
      gopls.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.go = [
        "goimports"
        "gofmt"
      ];

      formatters = {
        goimports.command = lib.getExe' pkgs.gotools "goimports";
        gofmt.command = lib.getExe' pkgs.go "gofmt";
      };
    };

    dap-go.enable = true;
  };
}
