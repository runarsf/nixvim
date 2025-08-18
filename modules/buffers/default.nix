{
  config,
  lib,
  helpers,
  ...
}:
lib.mkModule config "buffers" {
  utils = [
    ./buffers.lua
  ];

  plugins = {
    bufferline = {
      enable = true;
      settings.options = {
        diagnostics = "nvim_lsp";
        show_buffer_close_icons = false;
        always_show_bufferline = false;
        style_preset = helpers.mkRaw "require('bufferline').style_preset.no_italic";
      };
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<C-t>" (helpers.mkRaw "vim.cmd.enew") "New buffer")
    (mkKeymap' "<S-l>" (helpers.mkRaw "vim.cmd.bnext") "Next buffer")
    (mkKeymap' "<S-h>" (helpers.mkRaw "vim.cmd.bprevious") "Previous buffer")
    (mkKeymap' "<leader>w" (helpers.mkRaw "vim.cmd.write") "Write")
    (mkKeymap' "<leader>q" (helpers.mkRaw "require('utils.buffers').close") "Close buffer")
    (mkKeymap' "<leader>wq" (helpers.mkRaw ''
      function()
        vim.cmd.write()
        require('utils.buffers').close()
      end
    '') "Close buffer")
    (mkKeymap' "<leader>Q" (helpers.mkRaw "vim.cmd.qall") "Quit")
  ];
}
