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
          helpers.mkRaw "GetBannerSection()"
        )
        {
          section = "keys";
          gap = 1;
          padding = 2;
        }
        {
          text = {
            __unkeyed = helpers.mkRaw ''Quotes[math.random(#Quotes)]'';
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
              action = "<CMD>enew | startinsert<CR>";
            }
          ]
          ++ lib.optionals config.modules.telescope.enable [
            {
              icon = "";
              key = "p";
              desc = "Open";
              action = "<CMD>lua Snacks.dashboard.pick('files')<CR>";
            }
            {
              icon = "󱎸";
              key = "/";
              desc = "Find";
              action = "<CMD>lua Snacks.dashboard.pick('live_grep')<CR>";
            }
            {
              icon = "";
              key = "r";
              desc = "Recents";
              action = ":lua Snacks.dashboard.pick('oldfiles')";
            }
          ]
          ++ lib.optionals (config.modules.mini.enable
            && lib.attrs.hasAttrPath ["plugins" "mini" "modules" "files"] config) [
            {
              icon = "";
              key = "e";
              desc = "Explorer";
              action = "<CMD>lua MiniFiles.open()<CR>";
            }
          ]
          ++ lib.optionals config.modules.toggleterm.enable [
            {
              icon = "";
              key = "g";
              desc = "Git";
              action = "<CMD>lua GituiToggle()<CR>";
            }
          ]
          ++ [
            {
              icon = "";
              key = "q";
              desc = "Quit";
              action = "<CMD>q<CR>";
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

  extraConfigLuaPre = lib.concatStringsSep "\n" [(builtins.readFile ./quotes.lua) (builtins.readFile ./dashboard.lua)];

  extraLuaPackages = rocks:
    with rocks; [
      luautf8
    ];

  extraPackages = with pkgs; [
    krabby
    colorized-logs # ansi2txt
  ];
}
