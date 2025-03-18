{
  config,
  lib,
  pkgs,
  ...
}: let
  lang = "json";
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
  };
}
