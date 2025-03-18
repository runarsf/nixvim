{
  config,
  lib,
  ...
}: let
  lang = "c";
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
        clangd.enable = true;
      };

      conform-nvim.settings = {
        formatters_by_ft = {
          c = ["clang-format"];
          cpp = ["clang-format"];
        };
      };

      clangd-extensions.enable = true;
    };
  };
}
