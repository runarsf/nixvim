{
  config,
  lib,
  helpers,
  pkgs,
  ...
}: let
  # alpha-nvim buttons: `on_press` runs when the button is activated via <CR>,
  # `opts.keymap` binds the shortcut key directly in the dashboard buffer so
  # pressing e.g. "f" alone (no <CR> needed) triggers the same action.
  mkButton = key: label: action: {
    type = "button";
    val = label;
    on_press = helpers.mkRaw action;
    opts = {
      position = "center";
      shortcut = key;
      cursor = 3;
      width = 50;
      align_shortcut = "right";
      hl_shortcut = "AlphaBannerAccent";
      keymap = helpers.mkRaw ''{ "n", "${key}", ${action}, { noremap = true, silent = true, nowait = true } }'';
    };
  };
in
  lib.mkModule config "dashboard" {
    luaModules = [
      ./lua
    ];

    plugins.alpha = {
      enable = true;
      # A custom layout is used instead of one of alpha's bundled themes, so
      # `theme` must be unset (the two are mutually exclusive).
      theme = null;

      layout = [
        {
          type = "padding";
          val = 3;
        }
        (helpers.mkRaw "require('dashboard').get_banner_section()")
        {
          type = "padding";
          val = 2;
        }
        {
          type = "group";
          val = [
            (mkButton "i" "  Start writing" "function() vim.cmd('enew | startinsert') end")
            (mkButton "f" "  Find files" "function() require('search').open({ tab_name = 'Files' }) end")
            (mkButton "s" "󱎸  Grep files" "function() require('search').open({ tab_name = 'Grep' }) end")
            (mkButton "q" "  Quit" "function() vim.cmd('quit') end")
          ];
          opts.spacing = 1;
        }
        {
          type = "padding";
          val = 2;
        }
        (helpers.mkRaw "require('dashboard').get_quote_element()")
      ];

      opts.margin = 5;
    };

    globals.minitrailspace_disable = true;

    autoCmd = [
      {
        event = "BufNew";
        callback =
          helpers.mkRaw
          # lua
          ''
            function()
              vim.g.minitrailspace_disable = false
            end
          '';
      }
    ];

    extraPackages = with pkgs; [
      krabby
    ];
  }
