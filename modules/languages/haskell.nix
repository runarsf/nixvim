{
  config,
  lib,
  pkgs,
  ...
}: let
  lang = "haskell";
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
  };
}
