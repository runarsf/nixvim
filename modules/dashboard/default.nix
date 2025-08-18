{
  config,
  lib,
  helpers,
  pkgs,
  ...
}:
# FIXME: When "opening vim -> C-p -> open a file -> ,q", why does it not exit but open an empty buffer?
lib.mkModule config "dashboard" {
  modules.snacks.enable = true;
  # TODO: Why does this lead to infinitely recursion?
  # lib.trivial.warnIf (!config.modules.snacks.enable)
  # "implicitly enabling snacks because dashboard.enable is set, please explicitly enable snacks"
  # true;

  utils = [
    ./dashboard.lua
    {
      "quotes" = lib.print ''
        return ${lib.generators.toLua { } (import ./quotes.nix).quotes}
      '';
    }
  ];

  plugins = {
    # lazy.enable = true;

    snacks.settings.dashboard = {
      enabled = true;
      width = 64;

      sections = [
        (helpers.mkRaw "require('utils.dashboard').get_banner_section()")
        {
          # FIXME: pressing esc in telescope menus should exit immediately and not just leave insert mode
          section = "keys";
          gap = 1;
          padding = 2;
        }
        {
          text = {
            __unkeyed = helpers.mkRaw ''require('utils.dashboard').get_random_quote()'';
            hl = "Comment";
          };
          align = "center";
        }
      ];

      preset = {
        keys =
          [
            {
              icon = "";
              key = "i";
              desc = "Start writing";
              action = "<cmd>enew | startinsert<cr>";
            }
          ]
          ++ lib.optionals config.modules.telescope.enable [
            {
              icon = "";
              key = "f";
              desc = "Find files";
              action =
                helpers.mkRaw
                  # lua
                  ''
                    function()
                      require('search').open({ tab_name = 'Files' })
                    end
                  '';
            }
            {
              icon = "󱎸";
              key = "s";
              desc = "Grep files";
              action =
                helpers.mkRaw
                  # lua
                  ''
                    function()
                      require('search').open({ tab_name = 'Grep' })
                    end
                  '';
            }
          ]
          ++
            lib.optionals
              (config.modules.mini.enable && lib.attrs.hasAttrPath [ "plugins" "mini" "modules" "files" ] config)
              [
                {
                  icon = "";
                  key = "e";
                  desc = "Explorer";
                  action =
                    helpers.mkRaw
                      # lua
                      ''
                        function()
                          require('mini.files').open()
                        end
                      '';
                }
              ]
          ++ lib.optionals config.modules.terminal.enable [
            {
              icon = "";
              key = "g";
              desc = "Git";
              action =
                helpers.mkRaw
                  # lua
                  ''
                    function()
                      require('gitui').toggle()
                    end
                  '';
            }
          ]
          ++ [
            {
              icon = "";
              key = "q";
              desc = "Quit";
              action =
                helpers.mkRaw
                  # lua
                  ''
                    function()
                      vim.cmd.quit()
                    end
                  '';
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

  extraLuaPackages =
    rocks: with rocks; [
      luautf8
    ];

  extraPackages = with pkgs; [
    krabby
    colorized-logs # ansi2txt
  ];
}
