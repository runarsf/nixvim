{
  config,
  lib,
  ...
}: let
  lang = "lua";
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
        lua_ls.enable = true;
      };

      conform-nvim.settings = {
        formatters_by_ft.lua = ["stylua"];
      };
    };
  };
}
