{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "python" {
  extraPackages = with pkgs; [ruff];

  plugins = {
    lsp.servers = {
      ruff.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.python = [
        "ruff_fix"
        "ruff_format"
        "ruff_organize_imports"
      ];

      formatters = {
        ruff_fix.command = lib.getExe pkgs.ruff;
        ruff_format.command = lib.getExe pkgs.ruff;
        ruff_organize_imports.command = lib.getExe pkgs.ruff;
      };
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
