{ pkgs, ... }:

# TODO https://nix-community.github.io/nixvim/plugins/vim-slime/index.html
# TODO https://nix-community.github.io/nixvim/plugins/barbar/index.html

let
  plugins = [
    "nix"
    "gitsigns"
    "barbar"
    "trouble"
    "nvim-colorizer"
    "neocord"
    "neogen"
    "which-key"
    "headlines"
    "lastplace"
    "rainbow-delimiters"
    "typst-vim"
    "plantuml-syntax"
    "marks"
    "jupytext"
    "parinfer-rust"
    "rustaceanvim"
    "crates-nvim"
    "ccc"
    "clangd-extensions"
    "barbar"
    "diffview"
    "hmts"          # treesitter queries for home manager
    "instant"       # collaborative editing
    "intellitab"    # keymap set in ./completions.nix
    "autoclose"     # automatically match brackets
    "barbar"        # tab bar
    "barbecue"      # breadcrumbs
    "multicursors"  # TODO 
    "navbuddy"
    "undotree"
    "image"
    # "fidget"
    # "flash"
    # "cursorline"
  ];

in {
  imports = [
    ./ayu.nix
    ./sniprun.nix
    ./toggleterm.nix
    ./hop.nix
    ./rest.nix
    ./dap.nix
    ./completions.nix
    ./conform.nix
    ./lsp.nix
    ./folds.nix
    ./mini.nix
    ./treesitter.nix
    ./obsidian.nix
    ./notify.nix
    ./noice.nix
    ./todo-comments.nix
    ./telescope.nix
    ./lualine.nix
    ./instant.nix
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
