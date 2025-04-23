{
  config,
  lib,
  helpers,
  pkgs,
  ...
}:
lib.mkModule config "dashboard" {
  modules.snacks.enable = true;

  plugins = {
    lazy.enable = true;

    snacks.settings.dashboard = {
      enabled = true;
      width = 64;

      sections = [
        (
          helpers.mkRaw "GetPokemonSection()"
        )
        {
          padding = 2;
        }
        {
          section = "keys";
          gap = 1;
        }
      ];

      preset = {
        keys =
          [
            {
              icon = "";
              key = "i";
              desc = "~ Start writing";
              action = ":ene | startinsert";
            }
          ]
          ++ lib.optionals config.modules.telescope.enable [
            {
              icon = "";
              key = "p";
              desc = "~ Open";
              action = ":lua Snacks.dashboard.pick('files')";
            }
            {
              icon = "󱎸";
              key = "/";
              desc = "~ Find";
              action = ":lua Snacks.dashboard.pick('live_grep')";
            }
            {
              icon = "";
              key = "r";
              desc = "~ Recents";
              action = ":lua Snacks.dashboard.pick('oldfiles')";
            }
          ]
          ++ lib.optionals config.modules.neo-tree.enable [
            {
              icon = "";
              key = "e";
              desc = "~ Explorer";
              action = "<leader>e";
            }
          ]
          ++ lib.optionals config.modules.toggleterm.enable [
            {
              icon = "";
              key = "g";
              desc = "~ Git";
              action = ":lua ToggleGitUi()";
            }
            {
              icon = "";
              key = "$";
              desc = "~ Terminal";
              action = ":ToggleTerm";
            }
          ]
          ++ [
            {
              icon = "";
              key = "q";
              desc = "~ Quit";
              action = ":q";
            }
          ];
      };
    };
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

  extraConfigLuaPre = builtins.readFile ./dashboard.lua;

  extraLuaPackages = rocks:
    with rocks; [
      luautf8
    ];

  extraPackages = with pkgs; [
    krabby
    colorized-logs
  ];
}
