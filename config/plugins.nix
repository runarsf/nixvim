{ pkgs, ... }:

let
  plugins = [
    "nix"
    "gitsigns"
    "harpoon"
    "trouble"
    "presence-nvim"
    "nvim-colorizer"
    "which-key"
    "wilder"
    "lastplace"
    "rainbow-delimiters"
    "typst-vim"
    "marks"
    "jupytext"
    "parinfer-rust"
    "rustaceanvim"
    "crates-nvim"
    "ccc"
    "clangd-extensions"
    "barbar"
    "diffview"
    "hmts"
    "instant"
    "intellitab" # keymap set in ./completions.nix
    "multicursors"
    "undotree"
    "image"
    "dap"
    # "flash"
    # "alpha"
    # "cursorline"
    # "bufferline"
    # "fidget" # Alternative to nvim-notify
  ];

in {
  imports = [
    ./ayu.nix
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
    ./telescope.nix
    ./noice.nix
    ./lualine.nix
    ./otter.nix
    ./duck.nix
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
    hologram-nvim

    {
      plugin = dressing-nvim;
      config = ''lua require("dressing").setup()'';
    }
    vim-sleuth
    {
      # TODO Use https://github.com/kawre/neotab.nvim
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
        let g:SimpylFold_fold_docstring = 0
      '';
    }

    # Filetypes
    yuck-vim
    vim-just

    {
      plugin = (pkgs.vimUtils.buildVimPlugin {
        name = "pets.nvim";
        src = pkgs.fetchFromGitHub {
            owner = "giusgad";
            repo = "pets.nvim";
            rev = "747eb5e54fe8b10f4c7ce2881637d1c17b04f229";
            hash = "sha256-77+mDpI51L8jjyOGURzruDdXwkc855tc/Mv+CfnX2io=";
        };
      });
      config = ''
        lua require("pets").setup()
      '';
    }
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
