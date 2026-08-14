{
  config,
  lib,
  ...
}:
lib.mkModule config "lsp" {
  plugins.lsp = {
    enable = true;
    inlayHints = true;
  };

  # TODO: Consistent maps with groups (see lazyvim) https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
  keymaps = with lib.utils.keymaps; [
    (mkKeymap ["i" "n"] "<C-." (lib.nixvim.mkRaw ''
      function()
        vim.lsp.buf.code_action()
      end
    '') "Code Action")
    (mkKeymap ["x"] "<C-." (lib.nixvim.mkRaw ''
      function()
        vim.lsp.buf.range_code_action()
      end
    '') "Code Action")
    (mkKeymap ["n"] "gd" (lib.nixvim.mkRaw ''
      function()
        vim.lsp.buf.definition()
      end
    '') "Go to definition")
    (mkKeymap ["n"] "gD" (lib.nixvim.mkRaw ''
      function()
        vim.lsp.buf.declaration()
      end
    '') "Go to declaration")
    (mkKeymap ["n"] "gr" (lib.nixvim.mkRaw ''
      function()
        vim.lsp.buf.references()
      end
    '') "Go to references")
    (mkKeymap ["n"] "K" (lib.nixvim.mkRaw ''
      function()
        vim.lsp.buf.hover()
      end
    '') "Hover")
    (mkKeymap ["n"] "<Leader>R" (lib.nixvim.mkRaw ''
      function()
        vim.lsp.buf.rename()
      end
    '') "Rename")
    (mkKeymap ["n"] "<Leader>h" (lib.nixvim.mkRaw ''
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end
    '') "Toggle inlay hints")
  ];
}
