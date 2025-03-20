{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "structured-data" {
  plugins = {
    lsp.servers = {
      jsonls.enable = true;
      yamlls.enable = true;
      docker_compose_language_service.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft = {
        json = ["deno_fmt"];
        yaml = ["yamlfix"];
      };
      formatters = {
        deno_fmt.command = lib.getExe' pkgs.deno;
        yamlfix = {
          command = lib.getExe' pkgs.yamlfix "yamlfix";
          # env = {
          #   YAMLFIX_SEQUENCE_STYLE = "block_style";
          # };
        };
      };
    };
  };
}
