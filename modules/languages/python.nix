{
  config,
  lib,
  ...
}:
lib.utils.mkLanguageModule config "python" {
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
}
