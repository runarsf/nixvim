{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "lua" {
  plugins = {
    lsp.servers = {
      lua_ls = {
        enable = true;
        packageFallback = true;
        settings = {
          diagnostics.globals = ["vim"];
          runtime.version = "Lua 5.1";
        };
      };
    };

    lint = {
      lintersByFt.lua = ["luacheck"];

      linters.luacheck = {
        cmd = lib.getExe pkgs.luajitPackages.luacheck;
        args = ["--read-globals" "vim"];
      };
    };

    conform-nvim.settings = {
      formatters_by_ft.lua = ["stylua"];

      formatters.stylua = {
        command = lib.getExe pkgs.stylua;

        args = ["--indent-type" "Spaces" "--indent-width" (toString config.opts.shiftwidth) "-"];
        # cwd = lib.nixvim.mkRaw ''require("conform.util").root_file({ ".editorconfig", "package.json", ".stylua.toml" })'';
      };
    };
  };
}
