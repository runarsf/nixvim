{
  config,
  lib,
  pkgs,
  ...
}: let
  lang = "go";
  cfg = config.modules.languages.${lang};
in {
  options.modules.languages.${lang}.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.modules.languages.all.enable;
    description = "${lang} language support";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
