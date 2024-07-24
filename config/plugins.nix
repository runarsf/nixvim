{ config, pkgs, lib, ... }:

# Lazy loading https://github.com/nix-community/nixvim/issues/421
# TODO https://nix-community.github.io/nixvim/plugins/vim-slime/index.html
# TODO https://github.com/chrisgrieser/nvim-origami
# TODO e.g. with symbols outline: https://github.com/folke/edgy.nvim
# TODO https://github.com/jecxjo/rest-client.vim
# TODO https://www.reddit.com/r/neovim/comments/1d5ub7d/lazydevnvim_much_faster_luals_setup_for_neovim/
# TODO https://github.com/altermo/ultimate-autopair.nvim
# FIXME Laggy mouse scrolling

let
  mkPlugins = plugins:
    let
      partitions =
        builtins.partition (plugin: lib.hasAttr plugin config.modules)
        (builtins.filter builtins.isString plugins);
      toAttrs = plugins:
        builtins.listToAttrs (map (plugin: {
          name = plugin;
          value.enable = true;
        }) plugins);
    in {
      modules = toAttrs partitions.right;
      plugins = toAttrs partitions.wrong;
      extraPlugins = builtins.filter (p: !builtins.isString p) plugins;
    };

in lib.deepMerge [
  (with pkgs.vimPlugins;
    mkPlugins [
      # Modules
      "lualine"
      "otter"
      "duck"
      "virt-column"
      "colors"
      "indent-blankline"
      "outline"
      "zen"
      "telescope"
      "mini"
      "toggleterm"
      "slime"
      "hop"
      "dap"
      "cmp"
      "formatter"
      "lsp"
      "typst"
      "folds"
      "trouble"
      "treesitter"
      "markdown"
      "noice"
      "todo"
      "gremlins"

      # Plugins
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
      # "image"
      "sleuth"
      "dressing"
      # "wilder"
      # "multicursors"
      # "flash"
      "nix"
      "gitsigns"
      "barbar"
      "neocord"
      "undotree"
      "better-escape"

      # extraPlugins
      # lz-n
      {
        plugin = flutter-tools-nvim;
        config = lib.luaToViml ''
          require("flutter-tools").setup({});
          require("telescope").load_extension("flutter");
        '';
        # config = lib.luaToViml ''
        #   require("lz.n").load {
        #     "flutter-tools",
        #     ft = "dart",
        #   }
        # '';
      }

      # APIs and Functions
      plenary-nvim
      popup-nvim
      nui-nvim
      nvim-web-devicons

      # {
      #   plugin = (pkgs.vimUtils.buildVimPlugin rec {
      #     name = "tiny-devicons-auto-colors.nvim";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "rachartier";
      #       repo = name;
      #       rev = "699381f502a9c4e8d95925083765768545e994b4";
      #       hash = "sha256-4cXaGvptqE9Vktj4hERokdA1DYzYi1r+UopEBxuBd2U=";
      #     };
      #   });
      #   config = lib.luaToViml ''require("tiny-devicons-auto-colors").setup()'';
      # }

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
        config = "let g:SimpylFold_fold_docstring = 0";
      }

      # Filetypes
      yuck-vim
      vim-just
      openingh-nvim
    ])
  { imports = lib.umport { path = ../modules; }; }
]
