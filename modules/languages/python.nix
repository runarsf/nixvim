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
      # Resolve the interpreter used to run/debug the target program: prefer
      # whatever's on PATH (devShell, home-manager profile, system python),
      # falling back to a nix-provided python so debugging still works
      # outside a project environment.
      # NOTE: VIRTUAL_ENV/CONDA_PREFIX are already checked first by dap-python
      # itself before this is called.
      resolvePython = lib.nixvim.mkRaw ''
        function()
          local python = vim.fn.exepath("python3")
          if python == "" then
            python = vim.fn.exepath("python")
          end
          if python ~= "" then
            return python
          end
          return "${lib.getExe pkgs.python3}"
        end
      '';
      settings = {
        console = "integratedTerminal";
      };
    };
  };
}
