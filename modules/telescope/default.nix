# TODO: code actions should look different https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#themes
{
  config,
  lib,
  pkgs,
  helpers,
  ...
}:
lib.mkModule config "telescope" {
  utils = [
    ./pickers.lua
  ];

  plugins = {
    sqlite-lua.enable = true;

    telescope = {
      enable = true;

      lazyLoad = {
        settings = {
          # HACK: This is a workaround since lazyLoad needs config to be enabled.
          event = ["User LoadTelescope"];
          # cmd = ["Telescope"];
          # keys = ["<C-p>"];
        };
      };

      settings.defaults = {
        no_ignore = true;
        no_ignore_parent = true;
        hidden = true;
        use_regex = true;
        file_ignore_patterns = [
          "^\\.git/"
          "^\\.stack-work/"
          "^node_modules/"
          "^\\.DS_Store"
        ];
        mappings.i = {
          "<Esc>" = helpers.mkRaw "require('telescope.actions').close";
          "<C-h>" = "which_key";
        };
      };
      extensions = {
        frecency = {
          enable = true;
          settings = {
            # TODO: https://github.com/nvim-telescope/telescope-frecency.nvim/issues/270
            db_safe_mode = false;
            matcher = "fuzzy";
          };
        };
        ui-select.enable = true;
        undo.enable = true;
        media-files.enable = true;
        advanced-git-search.enable = true;
      };
    };

    lz-n.plugins = [
      {
        __unkeyed-1 = "smart-open.nvim";
        cmd = ["Telescope"];
        keys = ["<C-p>"];
        # HACK: This is a workaround since the lazyLoad config for telescope doesn't seem to work.
        before = helpers.mkRaw ''
          function()
            require('lz.n').trigger_load('telescope.nvim')
          end
        '';
        after = helpers.mkRaw ''
          function()
            require("telescope").load_extension("smart_open")
          end
        '';
      }
      {
        __unkeyed-1 = "vimplugin-search.nvim";
        cmd = ["Telescope"];
        keys = ["<C-p>"];
        after = helpers.mkRaw ''
          function()
            require('search').setup({
              initial_tab = 1,
              tabs = {
                {
                  name = "Files",
                  tele_func = function(opts)
                    -- opts = vim.tbl_deep_extend("force",
                    --   opts or {},
                    --   {
                    --     workspace = "CWD",
                    --   }
                    -- )
                    -- require("telescope").extensions.frecency.frecency(opts)
                    require("telescope").extensions.smart_open.smart_open(opts)
                  end,
                  -- tele_opts = ''${lib.generators.toLua {} plugins.telescope.settings.defaults},
                },
                {
                  name = "Grep",
                  tele_func = function(opts)
                    opts = vim.tbl_deep_extend("force",
                      opts or {},
                      -- ''${lib.generators.toLua {} plugins.telescope.settings.defaults},
                      {
                        entry_maker = require('utils.pickers').prettyGrepEntryMaker(opts)
                      }
                    )
                    require("telescope.builtin").live_grep(opts)
                  end,
                  -- tele_opts = ''${lib.generators.toLua {} plugins.telescope.settings.defaults},
                },
              }
            })
          end
        '';
      }
    ];
  };

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = search;
      optional = true;
    }
    {
      plugin = smart-open-nvim;
      optional = true;
    }
  ];

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<C-p>" (helpers.mkRaw ''
      function()
        require('search').open({ tab_name = 'Files' })
      end
    '') "Search files")
    (mkKeymap' "<leader><tab>" (helpers.mkRaw ''
      function()
        -- HACK: See other hacks in this file
        require('lz.n').trigger_load('telescope.nvim')
        local ok, builtin = pcall(require, 'telescope.builtin')

        if ok then
          builtin.buffers()
        else
          vim.cmd.ls()
        end
      end
    '') "List buffers")
  ];

  extraPackages = with pkgs; [ripgrep];
}
