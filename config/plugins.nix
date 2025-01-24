{ pkgs, utils, ... }:

# TODO https://github.com/chrisgrieser/nvim-origami
# TODO https://github.com/jecxjo/rest-client.vim
# TODO https://www.reddit.com/r/neovim/comments/1d5ub7d/lazydevnvim_much_faster_luals_setup_for_neovim/
# TODO https://github.com/altermo/ultimate-autopair.nvim
# TODO https://github.com/Tyler-Barham/floating-help.nvim
# TODO https://github.com/tris203/precognition.nvim
# TODO https://github.com/mvllow/modes.nvim

{
  modules = utils.enable [
    [ "colorscheme" "ayu" ]
    "lsp"
    "cmp"
    "dap"
    "togglemouse"
    "toggleterm"
    "gremlins"
    "mini"
    "otter"
    "duck"
    "noice"
    "zen"
    "virt-column"
    "outline"
    "treesitter"
    "indent-blankline"
    "colors"
    "todo"
    "formatter"
    "folds"
    "hop"
    "trouble"
    "typst"
    "telescope"
    "lualine"
  ];

  plugins = utils.enable [
    "which-key"
    "lastplace"
    "smart-splits"
    "sleuth"
    "neocord"
    "gitsigns"
    "barbecue"
    "nix"
    "hmts"
    "marks"
    "improved-search"
    "diffview"
    "dressing"
    "barbar"
    "better-escape"
    "rustaceanvim"
    "clangd-extensions"
    "flutter-tools"
    # "intellitab"
  ];

  extraPlugins = with pkgs.vimPlugins; [
    openingh-nvim
    codi-vim
    longlines
    {
      plugin = hologram-nvim;
      config = utils.luaToViml ''require("hologram").setup({})'';
    }
    {
      plugin = legendary-nvim;
      config = utils.luaToViml ''
        require("legendary").setup({
          extensions = {
            smart_splits = {
              directions = { 'Left', 'Down', 'Up', 'Right', },
              mods = {
                move = '<S>',
                resize = '<M-S>',
              },
            },
            which_key = {
              auto_register = true,
            },
            diffview = true,
          },
        })
      '';
    }
  ];
}
