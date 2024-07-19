{ pkgs, lib, ... }:

# TODO Lazy loading https://github.com/nvim-neorocks/lz.n
# TODO https://nix-community.github.io/nixvim/plugins/vim-slime/index.html
# TODO https://nix-community.github.io/nixvim/plugins/barbar/index.html
# TODO https://github.com/chrisgrieser/nvim-origami
# TODO A similar plugin to gremlins https://marketplace.visualstudio.com/items?itemName=nhoizey.gremlins
# TODO e.g. with symbols outline: https://github.com/folke/edgy.nvim
# TODO https://github.com/jecxjo/rest-client.vim
# TODO https://www.reddit.com/r/neovim/comments/1d5ub7d/lazydevnvim_much_faster_luals_setup_for_neovim/
# TODO https://github.com/altermo/ultimate-autopair.nvim

let
  # FIXME Laggy mouse scrolling
  # TODO Enable plugin from function by providing strings or packages.
  #  For strings, <string>.enable will be set to true.
  #  All files should be imported and create an option to enable that file, like
  #  plugin.enable. This means strings can also be config-defined enables.
  #  For packages, they will be added to the extraPlugins list.
  plugins = [
    "nix"
    "gitsigns"
    "barbar"
    "neocord"
    "which-key"
    "lastplace"
    # "rainbow-delimiters"
    # "plantuml-syntax"
    "marks"
    "jupytext"
    # "parinfer-rust"
    "rustaceanvim"
    # "crates-nvim"
    "improved-search"
    "clangd-extensions"
    "diffview"
    "hmts" # treesitter queries for home manager
    "intellitab" # keymap set in ./completions.nix
    # "autoclose"     # automatically match brackets
    "barbecue" # breadcrumbs
    "undotree"
    # "image"
    "sleuth"
    "dressing"
    "wilder"
    # "multicursors"
    # "flash"
    # "cursorline"
  ];

in {
  imports = [
    ./colorscheme.nix
    ./fidget.nix
    ./sniprun.nix
    ./toggleterm.nix
    ./hop.nix
    ./dap.nix
    ./completions.nix
    ./conform.nix
    ./lsp.nix
    ./typst.nix
    ./folds.nix
    ./trouble.nix
    ./mini.nix
    ./treesitter.nix
    ./markdown.nix
    ./notify.nix
    ./noice.nix
    ./todo-comments.nix
    ./telescope.nix
    ./lualine.nix
    ./otter.nix
    ./duck.nix
    ./virt-column.nix
    ./indent-blankline.nix
    ./outline.nix
    ./zen.nix
    ./colors.nix
  ];

  plugins = builtins.listToAttrs (map (name: {
    name = name;
    value.enable = true;
  }) plugins);

  extraPlugins = with pkgs.vimPlugins; [
    # APIs and Functions
    # plenary-nvim
    # popup-nvim
    # nui-nvim
    nvim-web-devicons
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
      config = lib.luaToViml ''require("tiny-devicons-auto-colors").setup()'';
    }

    # TODO flutter-tools-nvim
    codi-vim
    legendary-nvim

    {
      plugin = hologram-nvim;
      config = lib.luaToViml ''require("hologram").setup({})'';
    }
    {
      plugin = bigfile-nvim;
      config = lib.luaToViml ''require("bigfile").setup()'';
    }
    {
      plugin = SimpylFold;
      config = ''let g:SimpylFold_fold_docstring = 0'';
    }

    # Filetypes
    yuck-vim
    vim-just
    openingh-nvim
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
