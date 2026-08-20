{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule config "git" {
  plugins = {
    # TODO: https://github.com/wintermute-cell/gitignore.nvim/issues/9
    gitignore.enable = true;
    git-conflict.enable = true;
    diffview.enable = true;
    neogit.enable = true;
    gitsigns.enable = true;
    fugitive.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    # {
    #   plugin = diffbandit;
    #   config = lib.utils.viml.fromLua ''
    #     require("diffbandit").setup()
    #   '';
    # }
  ];

  luaModules = lib.optionals config.modules.terminal.enable [
    {
      "terminal" =
        # lua
        ''
          local M = {}

          M.GitUi = require('toggleterm.terminal').Terminal:new({
            cmd = "${lib.getExe pkgs.gitui}",
            direction = "float",
            float_opts = {
              border = "curved",
            },
            hidden = true,
          })

          return M
        '';
    }
  ];

  keymaps = lib.optionals config.modules.terminal.enable (with lib.utils.keymaps; [
    (mkKeymap' "<Leader>g" (lib.nixvim.mkRaw ''
      function()
        require('terminal').GitUi:toggle()
      end
    '') "Toggle GitUI")
  ]);
}
