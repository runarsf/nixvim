# TODO: code actions should look different https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#themes
{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule config "telescope" {
  luaModules = [
    ./pickers.lua
  ];

  plugins = {
    sqlite-lua.enable = true;

    telescope = {
      enable = true;

      # telescope.nvim is a hard dependency of several enabled extensions below
      # (frecency, ui-select, undo, media-files), which are eager/non-optional
      # plugins themselves. That forces telescope.nvim to always be loaded at
      # startup regardless of this setting, and lazy-loading it on top of that
      # caused `:Telescope` to permanently break after being triggered via
      # `<C-p>` (lz-n would delete the live command while trying to load an
      # "already loaded" lazy copy that never really existed separately).
      lazyLoad.enable = false;

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
          "<Esc>" = lib.nixvim.mkRaw "require('telescope.actions').close";
          "<C-h>" = "which_key";
        };

        # `themes.get_cursor()`, inlined: a small popup at the cursor instead
        # of reserving ~90% of screen height regardless of result count.
        sorting_strategy = "ascending";
        results_title = false;
        layout_strategy = "horizontal";
        # layout_config = {
        #   width = 80;
        #   height = 9;
        # };
        # borderchars = {
        #   prompt = ["─" "│" " " "│" "╭" "╮" "│" "│"];
        #   results = ["─" "│" "─" "│" "├" "┤" "╯" "╰"];
        #   preview = ["─" "│" "─" "│" "╭" "╮" "╯" "╰"];
        # };
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
        zoxide.enable = true;
      };
    };

    lz-n.plugins = [
      {
        __unkeyed-1 = "smart-open.nvim";
        # NOTE: `cmd = ["Telescope"]` is intentionally omitted here (and on
        # vimplugin-search.nvim below): sharing that trigger with telescope.nvim's
        # own lazyLoad-generated entry caused `:Telescope` to break permanently
        # after its first use. lz-n's cmd handler deletes its stub command on every
        # invocation, expecting the loaded plugin(s) to re-register a real one; with
        # three separate specs pending under the same "Telescope" key, this plugin's
        # `before` hook triggers telescope.nvim's load *while* that same batch is
        # still being walked, and the (now empty) leftover stub wins the next time
        # `:Telescope` deletes-and-checks, permanently losing the command. These two
        # plugins are only ever needed via `<C-p>` anyway, which already triggers
        # telescope.nvim's load itself below, so the `cmd` trigger was redundant.
        keys = ["<C-p>"];
        before = lib.nixvim.mkRaw ''
          function()
            require('lz.n').trigger_load('telescope.nvim')
          end
        '';
        after = lib.nixvim.mkRaw ''
          function()
            require("telescope").load_extension("smart_open")
          end
        '';
      }
      {
        __unkeyed-1 = "vimplugin-search.nvim";
        keys = ["<C-p>"];
        after = lib.nixvim.mkRaw ''
          function()
            -- search.nvim's tab bar window never sets its own `border`, so it
            -- was inheriting the global `winborder = "rounded"` default
            -- (config/options.nix) and growing a 1-column border that its
            -- hardcoded `col = 0` positioning (relative to the picker window)
            -- doesn't account for, throwing it out of alignment. Patch its
            -- window creation to force borderless instead of touching
            -- `winborder` globally, which other floats correctly rely on.
            local tab_bar = require('search.tab_bar')
            local tab_bar_create = tab_bar.create
            tab_bar.create = function(conf)
              conf.border = "none"
              return tab_bar_create(conf)
            end

            search_opts = {
              layout_strategy = nil,
              layout_config = { height = 0.7 },
            }
            require('search').setup({
              initial_tab = 1,
              tabs = {
                {
                  name = "Files",
                  tele_func = function(opts)
                    opts = vim.tbl_deep_extend("force",
                      opts or {},
                      search_opts
                    )
                    require("telescope").extensions.smart_open.smart_open(opts)
                  end,
                },
                {
                  name = "Grep",
                  tele_func = function(opts)
                    opts = vim.tbl_deep_extend("force",
                      opts or {},
                      search_opts,
                      {
                        entry_maker = require('pickers').prettyGrepEntryMaker(opts),
                      }
                    )
                    require("telescope.builtin").live_grep(opts)
                  end,
                },
                {
                  name = "Directories",
                  tele_func = function(opts)
                    opts = vim.tbl_deep_extend("force",
                      opts or {},
                      search_opts
                    )
                    require('telescope').extensions.zoxide.list(opts)
                  end,
                },
                {
                  name = "TODOs",
                  tele_func = function(opts)
                    opts = vim.tbl_deep_extend("force",
                      opts or {},
                      search_opts
                    )
                    require("telescope").extensions["todo-comments"].todo(opts)
                  end,
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
    (mkKeymap' "<C-p>" (lib.nixvim.mkRaw ''
      function()
        require('search').open({ tab_name = 'Files' })
      end
    '') "Search files")
    (mkKeymap' "<leader><tab>" (lib.nixvim.mkRaw ''
      function()
        require('lz.n').trigger_load('telescope.nvim')
        local ok, builtin = pcall(require, 'telescope.builtin')

        if ok then
          builtin.buffers()
        else
          vim.cmd.ls()
        end
      end
    '') "List buffers")
    (mkKeymap' "<leader>z" (lib.nixvim.mkRaw ''
      function()
        require('telescope').extensions.zoxide.list()
      end
    '') "Zoxide")
  ];

  extraPackages = with pkgs; [ripgrep];
}
