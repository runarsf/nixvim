{
  config,
  lib,
  pkgs,
  ...
}: let
  lang = "rust";
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
        rust_analyzer = {
          enable = false; # Handled by rustacean
          installCargo = true;
          installRustc = true;
        };
      };
      rustaceanvim.enable = true;

      conform-nvim.settings = {
        formatters_by_ft.rust = ["rustfmt"];

        formatters.rustfmt.command = lib.getExe pkgs.rustfmt;
      };
    };
  };
}
