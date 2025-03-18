{
  config,
  lib,
  pkgs,
  ...
}: let
  lang = "shell";
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
        bashls.enable = true;
      };

      conform-nvim.settings = {
        formatters_by_ft.bash = [
          "shellcheck"
          "shellharden"
          "shfmt"
        ];

        formatters = {
          shfmt.command = lib.getExe pkgs.shfmt;
          shellcheck.command = lib.getExe pkgs.shellcheck;
          shellharden.command = lib.getExe pkgs.shellharden;
        };
      };
    };
  };
}
