{ pkgs, ... }: {
  imports = [ ./rest-client.nix ./completions.nix ./snippets.nix ./lsp.nix ];

  # Disable some builtin plugins
  globals = {
    loaded_tutor_mode_plugin = 1;
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
    loaded_netrwSettings = 1;
    loaded_netrwFileHandlers = 1;
  };

  # TODO Mini.files split with https://github.com/folke/edgy.nvim
  plugins = {
    todo-comments.enable = true;
    flash.enable = true;
    which-key.enable = true;
    fidget.enable = true;
    luasnip.enable = true;
    toggleterm = {
      enable = true;
      direction = "float";
      openMapping = "<M-n>";
    };
    presence-nvim.enable = true;
    lualine.enable = true;
    telescope.enable = true;
    treesitter = {
      enable = true;
      indent = true;
    };
    luasnip.enable = true;
    oil = {
      enable = true;
      deleteToTrash = true;
    };
    gitsigns.enable = true;
    noice.enable = true;
    copilot-vim.enable = true;
    # cursorline.enable = true;
    # diffview.enable = true;
    # multicursors.enable = true;
    nix.enable = true;
  };
  extraPlugins = with pkgs.vimPlugins; [
    plenary-nvim
    {
      plugin = marks-nvim;
      config = ''lua require("marks").setup()'';
    }
    {
      plugin = comment-nvim;
      config = ''lua require("Comment").setup()'';
    }
    {
      plugin = pretty-fold-nvim;
      config = ''lua require("pretty-fold").setup()'';
    }
    rainbow-delimiters-nvim
    typst-vim
    yuck-vim
    vim-just
    vim-lastplace
  ];
}
