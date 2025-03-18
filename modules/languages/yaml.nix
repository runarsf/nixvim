{
  config,
  lib,
  pkgs,
  ...
}: let
  lang = "yaml";
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
        yamlls.enable = true;
        docker_compose_language_service.enable = true;
      };

      conform-nvim.settings = {
        formatters_by_ft.yaml = ["yamlfix"];

        formatters.yamlfix = {
          command = lib.getExe' pkgs.yamlfix "yamlfix";
          env = {
            YAMLFIX_SEQUENCE_STYLE = "block_style";
          };
        };
      };
    };
  };
}
