{
  config,
  lib,
  pkgs,
  ...
}: let
  lang = "nushell";
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
        nushell.enable = true;
      };

      conform-nvim.settings = {
        formatters_by_ft.nu = ["nufmt"];

        formatters.nufmt.command = lib.getExe pkgs.nufmt;
      };
    };
  };
}
