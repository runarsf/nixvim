{
  config,
  lib,
  ...
}: let
  lang = "web";
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
        ts_ls.enable = true;
        cssls.enable = true;
        eslint.enable = true;
        html.enable = true;
      };

      conform-nvim.settings = {
        formatters_by_ft = rec {
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          typescript = javascript;
          html = ["htmlbeautifier"];
          css = ["stylelint"];
        };
      };
    };
  };
}
