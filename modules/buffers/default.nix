{
  config,
  lib,
  ...
}:
lib.mkModule config "buffers" {
  luaModules = [
    ./buffers.lua
  ];

  plugins = {
    bufferline = {
      enable = true;
      settings.options = {
        diagnostics = "nvim_lsp";
        show_buffer_close_icons = false;
        always_show_bufferline = false;
        style_preset = lib.nixvim.mkRaw "require('bufferline').style_preset.no_italic";
      };
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<C-t>" (lib.nixvim.mkRaw "vim.cmd.enew") "New buffer")
    (mkKeymap' "<S-l>" (lib.nixvim.mkRaw "vim.cmd.bnext") "Next buffer")
    (mkKeymap' "<S-h>" (lib.nixvim.mkRaw "vim.cmd.bprevious") "Previous buffer")
    (mkKeymap' "<leader>w" (lib.nixvim.mkRaw "vim.cmd.write") "Write")
    (mkKeymap' "<leader>q" (lib.nixvim.mkRaw "require('buffers').close") "Close buffer")
    (mkKeymap' "<leader>wq" (lib.nixvim.mkRaw ''
      function()
        vim.cmd.write()
        require('buffers').close()
      end
    '') "Close buffer")
    (mkKeymap' "<leader>Q" (lib.nixvim.mkRaw "vim.cmd.qall") "Quit")
  ];
}
