{
  lib,
  pkgs,
  ...
}: {
  # TODO https://github.com/chrisgrieser/nvim-origami
  # TODO https://www.reddit.com/r/neovim/comments/1d5ub7d/lazydevnvim_much_faster_luals_setup_for_neovim/
  # TODO https://github.com/altermo/ultimate-autopair.nvim
  # TODO https://github.com/Tyler-Barham/floating-help.nvim
  # TODO https://github.com/tris203/precognition.nvim
  # TODO https://github.com/mvllow/modes.nvim
  # TODO jupytext or molten
  # TODO smaller notification, fidget for messages?
  # TODO snacks dashboard

  options = {
    # TODO This does not belong here
    modules.languages.all.enable = lib.mkEnableOption "enable all languages";
  };

  config = {
    modules =
      lib.utils.enable [
        "treesitter"
        "otter"
        "cmp"
        "telescope"
        "virt-column"
        "pets"
        "gremlins"
        "mini"
        "lsp"
        "formatter"
        "snacks"
        "todo"
        "buffers"
        "outline"
        "dap"
        "hop"
        "togglemouse"
        "toggleterm"
        "trouble"
        "colors"
        "folds"
        "lualine"
        "ui"
        "zen"
        "dashboard"
        "which-key"
        "indents"
        "smart-splits"
        ["languages" "all"]
      ]
      // {
        colorschemes = {
          ayu.enable = true;
          transparent = true;
        };
      };

    plugins = lib.utils.enable [
      "lastplace"
      "sleuth"
      "neocord"
      "gitsigns"
      "intellitab"
      # "barbecue"
      # "marks"
      # "improved-search"
      # "diffview"
      # "barbar"
      # "better-escape"
    ];

    extraPlugins = with pkgs.vimPlugins; [
      openingh-nvim
      longlines
      # codi-vim
      # lens-vim
      # {
      #   plugin = visual-nvim;
      #   config = utils.luaToViml ''
      #     require('visual').setup({
      #         treesitter_textobjects = true,
      #         commands = {
      #           move_up_then_normal = { amend = true },
      #           move_down_then_normal = { amend = true },
      #           move_right_then_normal = { amend = true },
      #           move_left_then_normal = { amend = true },
      #         },
      #       } )
      #   '';
      # }
      # {
      #   plugin = kak-nvim;
      #   config = utils.luaToViml ''
      #     require("kak").setup({
      #       full = true,
      #       which_key_integration = true,
      #
      #       experimental = {
      #         rebind_visual_aiAI = true,
      #       }
      #     })
      #   '';
      # }
      /*
         {
        plugin = hologram-nvim;
        config = lib.utils.viml.fromLua ''require("hologram").setup({})'';
      }
      */
      /*
         {
        plugin = legendary-nvim;
        config = lib.utils.viml.fromLua ''
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
      */
    ];
  };
}
