{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    utils = lib.mkOption rec {
      type = lib.types.listOf <| lib.types.either lib.types.path <| lib.types.attrsOf lib.types.str;
      default = lib.filesystem.concatPaths {
        paths = [../utils];
        suffix = ".lua";
        filterDefault = false;
      };
      description = "List of lua files or attribute sets with inline lua code to be added to the lua/utils directory";
      apply = paths: default ++ paths;
    };
  };

  config = {
    # TODO: Merge files/strings with same name
    #  Might need to add local M = {} to the top of the file and return M at end
    extraFiles = let
      attrUtils = builtins.filter builtins.isAttrs config.utils;
      pathUtils = builtins.filter builtins.isPath config.utils;

      attrFiles =
        builtins.concatLists
        <| builtins.map (
          util:
            builtins.map (name: {
              name = "lua/utils/${name}.lua";
              value = {text = builtins.getAttr name util;};
            })
            <| builtins.attrNames util
        )
        attrUtils;

      pathFiles =
        builtins.map (util: {
          name = "lua/utils/${builtins.baseNameOf (toString util)}";
          value = {source = util;};
        })
        pathUtils;
    in
      builtins.listToAttrs <| attrFiles ++ pathFiles;

    modules =
      lib.enable [
        "lsp"
        "completions"
        "formatting"
        "linting"
        "debugging"
        "treesitter"
        "otter"
        "telescope"
        "copilot"
        "pets"
        "gremlins"
        "mini"
        "snacks"
        "todo"
        "buffers"
        "outline"
        "hop"
        "togglemouse"
        "terminal"
        "trouble"
        "colors"
        "folds"
        "lualine"
        "ui"
        "zen"
        "dashboard"
        "which-key"
        "smart-splits"
        "editing"
      ]
      // {
        colorschemes = {
          selected = "ayu";
          transparent = true;
        };
        languages = {
          all.enable = true;
          http.enable = false;
        };
      };

    plugins = lib.enable [
      "lastplace"
      "sleuth"
      "neocord"
      "gitsigns"
      "intellitab"
      "git-conflict"
      "fugitive"
      # "barbecue"
      # "marks"
      # "improved-search"
      # "diffview"
      # "barbar"
      # "better-escape"
    ];

    extraPlugins = with pkgs.vimPlugins; [
      openingh-nvim
      nvim-nio
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
        config = lib.utils.viml.fromLua ''
          require("hologram").setup({})
        '';
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

    extraLuaPackages = rocks:
      with rocks; [
        nvim-nio
      ];
  };
}
