{
  config,
  lib,
  ...
}: let
  lang = "python";
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
        ruff.enable = true;
      };

      conform-nvim.settings = {
        formatters_by_ft.python = [
          "isort"
          "ruff_fix"
          "ruff_format"
        ];
      };

      dap-python = {
        enable = true;
        settings = {
          console = "integratedTerminal";
          # TODO use resolvePython instead? or directly from pkgs
          adapterPythonPath = "~/.nix-profile/bin/python";
        };
      };
    };
  };
}
