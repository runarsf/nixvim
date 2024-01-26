{ pkgs, ... }:

let
  plugins = [
    "nix"
    "telescope"
    "harpoon"
    "trouble"
    "presence-nvim"
    "nvim-colorizer"
    "flash"
    "which-key"
    "gitsigns"
    "wilder"
    "lastplace"
    "rainbow-delimiters"
    "typst-vim"
    "marks"
    "barbar"
    "diffview"
    "hmts"
    "instant"
    "intellitab" # keymap set in ./completions.nix
    "multicursors"
    "undotree"
    # "alpha"
    # "cursorline"
    # "bufferline"
    # "fidget" # Alternative to nvim-notify
  ];

in {
  imports = [
    ./sniprun.nix
    ./toggleterm.nix
    ./hop.nix
    ./rest-client.nix
    ./completions.nix
    ./conform.nix
    ./lsp.nix
    ./folds.nix
    ./mini.nix
    ./treesitter.nix
    ./notify.nix
    ./todo-comments.nix
    ./noice.nix
    ./lualine.nix
  ];

  plugins = builtins.listToAttrs (map (name: {
    name = name;
    value = { enable = true; };
  }) plugins);

  extraPlugins = with pkgs.vimPlugins; [
    # APIs and Functions
    plenary-nvim
    popup-nvim
    nui-nvim
    nvim-web-devicons

    {
      plugin = dressing-nvim;
      config = ''lua require("dressing").setup()'';
    }
    vim-sleuth
    {
      plugin = tabout-nvim;
      config = ''
        lua require("tabout").setup({
        \   skip_ssl_verification = true,
        \ })
      '';
    }
    {
      plugin = SimpylFold;
      config = ''
        let g:SimpylFold_docstring_preview = 1
      '';
    }

    # Filetypes
    yuck-vim
    vim-just
  ];

  # Disable some builtin plugins
  globals = {
    loaded_tutor_mode_plugin = 1;
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
    loaded_netrwSettings = 1;
    loaded_netrwFileHandlers = 1;
  };
}
