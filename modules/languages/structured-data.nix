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
      formatters.yamlfix.command = lib.getExe' pkgs.yamlfix "yamlfix";
    };
  };
}
