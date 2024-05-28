{ pkgs, lib, ... }:

# TODO https://nix-community.github.io/nixvim/plugins/vim-slime/index.html
# TODO https://nix-community.github.io/nixvim/plugins/barbar/index.html
# TODO https://github.com/chrisgrieser/nvim-origami
# TODO A similar plugin to gremlins https://marketplace.visualstudio.com/items?itemName=nhoizey.gremlins
# TODO e.g. with symbols outline: https://github.com/folke/edgy.nvim

let
  # TODO Enable plugin from function by providing strings or packages.
  #  For strings, <string>.enable will be set to true.
  #  All files should be imported and create an option to enable that file, like
  #  plugin.enable. This means strings can also be config-defined enables.
  #  For packages, they will be added to the extraPlugins list.
  plugins = [
    "nix"
    "gitsigns"
    "barbar"
    "trouble"
    "nvim-colorizer"
    "neocord"
    "neogen"
    "which-key"
    # "headlines"
    "lastplace"
    "rainbow-delimiters"
    "plantuml-syntax"
    "marks"
    "jupytext"
    "parinfer-rust"
    "rustaceanvim"
    "crates-nvim"
    "ccc"
    "improved-search"
    "clangd-extensions"
    "barbar"
    "diffview"
    "hmts"          # treesitter queries for home manager
    "instant"       # collaborative editing
    "intellitab"    # keymap set in ./completions.nix
    # "autoclose"     # automatically match brackets
    "barbar"        # tab bar
    "barbecue"      # breadcrumbs
    "navbuddy"
    "undotree"
    "image"
    "comment"
    "sleuth"
    "dressing"
    "fidget"
    "wilder"
    # "multicursors"
    # "flash"
    # "cursorline"
  ];

in {
  imports = [
    ./colorscheme.nix
    ./sniprun.nix
    ./toggleterm.nix
    ./hop.nix
    ./dap.nix
    ./completions.nix
    ./conform.nix
    ./lsp.nix
    ./typst.nix
    ./cloak.nix
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
    ./virt-column.nix
    ./indent-blankline.nix
    ./aerial.nix
  ];

  plugins = builtins.listToAttrs (map (name: {
    name = name;
    value.enable = true;
  }) plugins);

  extraPlugins = with pkgs.vimPlugins; [
    # APIs and Functions
    plenary-nvim
    popup-nvim
    nui-nvim
    nvim-web-devicons
    hologram-nvim
    bigfile-nvim

    {
      plugin = dressing-nvim;
      config = lib.luaToViml ''require("dressing").setup()'';
    }
    {
      # TODO Use https://github.com/kawre/neotab.nvim
      plugin = tabout-nvim;
      # TODO vimlify lua
      config = lib.luaToViml ''
        require("tabout").setup({
          skip_ssl_verification = true,
        })
      '';
    }
    {
      plugin = SimpylFold;
      config = ''
        let g:SimpylFold_fold_docstring = 0
      '';
    }
    codi-vim

    # Filetypes
    yuck-vim
    vim-just
    openingh-nvim

    legendary-nvim

    {
      plugin = statuscol-nvim;
      config = lib.luaToViml ''require("statuscol").setup()'';
    }

    {
      plugin = (pkgs.vimUtils.buildVimPlugin rec {
        name = "tiny-devicons-auto-colors.nvim";
        src = pkgs.fetchFromGitHub {
            owner = "rachartier";
            repo = name;
            rev = "699381f502a9c4e8d95925083765768545e994b4";
            hash = "sha256-4cXaGvptqE9Vktj4hERokdA1DYzYi1r+UopEBxuBd2U=";
        };
      });
      config = lib.luaToViml ''require('tiny-devicons-auto-colors').setup()'';
    }

    {
      plugin = (pkgs.vimUtils.buildVimPlugin rec {
        name = "pets.nvim";
        src = pkgs.fetchFromGitHub {
            owner = "giusgad";
            repo = name;
            rev = "747eb5e54fe8b10f4c7ce2881637d1c17b04f229";
            hash = "sha256-77+mDpI51L8jjyOGURzruDdXwkc855tc/Mv+CfnX2io=";
        };
      });
      config = lib.luaToViml ''require("pets").setup()'';
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
