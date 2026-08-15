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

  # Prefer LSP folding (config/options.nix defaults foldexpr to treesitter's)
  autoCmd = [
    {
      event = ["LspAttach"];
      callback = lib.nixvim.mkRaw ''
        function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
          end
        end
      '';
    }
  ];

  # TODO: Consistent maps with groups (see lazyvim) https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
  keymaps = with lib.utils.keymaps; [
    (mkKeymap ["i" "n" "x"] "<C-." (lib.nixvim.mkRaw ''
      function()
        vim.lsp.buf.code_action()
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
