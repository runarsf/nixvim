{
  config,
  lib,
  helpers,
  ...
}:
lib.mkModule config "editing" rec {
  plugins = {
    grug-far = {
      enable = true;
      lazyLoad.settings = {
        keys = [
          {
            __unkeyed-1 = "<Leader>Fr";
            mode = ["n" "x"];
          }
          {
            __unkeyed-1 = "<Leader>FR";
            mode = ["n" "x"];
          }
          {
            __unkeyed-1 = "<Leader>Fs";
            mode = "x";
          }
        ];
        cmd = "GrugFar";
      };
      settings = {
        transient = true;
        showCompactInputs = true;
        engines.ripgrep.placeholders = {
          enabled = false;
          search = "Search";
          replacement = "Replace";
          replacement_lua = "Replace (Lua)";
          replacement_vimscript = "Replace (Vim)";
          filesFilter = "Filter";
          flags = "Flags";
          paths = "Paths";
        };
        prefills.filesFilter = ''
          !.git/*
          !node_modules/*'';
      };
    };

    which-key.settings.spec = let
      icon = {
        icon = "󰍉";
        color = "blue";
      };
    in [
      {
        __unkeyed-1 = "<leader>F";
        group = "Find";
        inherit icon;
      }
      {
        # TODO: Inherit group icon instead of repeating it
        __unkeyed-1 = "<leader>Fr";
        # TODO: Find a better way to do it than defining the same keymap in which-key, lazyLoad, and keymaps
        mode = ["n" "x"];
        inherit icon;
      }
      {
        __unkeyed-1 = "<leader>FR";
        mode = ["n" "x"];
        inherit icon;
      }
      {
        __unkeyed-1 = "<leader>Fs";
        mode = "x";
        inherit icon;
      }
    ];
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap ["n" "x"] "<Leader>Fr" (helpers.mkRaw ''
      function()
        local opts = vim.tbl_deep_extend("force",
          {},
          ${lib.generators.toLua {} plugins.grug-far.settings},
          { prefills = { paths = vim.fn.expand("%") } }
        )
        require('grug-far').open(opts)
      end
    '') "Find & Replace")
    (mkKeymap ["n" "x"] "<Leader>FR" (helpers.mkRaw ''
      function()
        require('grug-far').open()
      end
    '') "Find & Replace (all files)")
    (mkKeymap ["x"] "<Leader>Fs" (helpers.mkRaw ''
      function()
        local opts = vim.tbl_deep_extend("force",
          {},
          ${lib.generators.toLua {} plugins.grug-far.settings},
          { prefills = { paths = vim.fn.expand("%") } }
        )
        require('grug-far').with_visual_selection(opts)
      end
    '') "Find & Replace (selection)")
  ];
}
