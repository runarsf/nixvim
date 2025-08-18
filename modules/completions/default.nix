{
  config,
  lib,
  helpers,
  pkgs,
  ...
}:
# TODO: Lazy load on { "InsertEnter", "CmdwinEnter", "CmdlineEnter" },
lib.mkModule config "completions" {
  utils = [
    ./blink.lua
  ];

  performance.combinePlugins.standalonePlugins = [
    "blink.cmp"
    "friendly-snippets" # https://github.com/nix-community/nixvim/issues/2746
  ];

  plugins = {
    luasnip.enable = true;
    friendly-snippets.enable = true;

    lspkind = {
      enable = true;
      cmp.enable = true;
    };

    colorful-menu.enable = true;

    blink-cmp = {
      enable = true;

      settings = {
        sources = {
          default =
            [
              "path"
              "lsp"
              "snippets"
              "buffer"
              "ripgrep"
              "calc"
            ]
            ++ lib.optionals config.modules.copilot.enable [
              "copilot"
            ];

          per_filetype = let
            dapSources = ["dap"];
          in {
            dap-repl = dapSources;
            dapui_hover = dapSources;
            dapui_watches = dapSources;
          };

          providers = let
            useKindName = name: helpers.mkRaw "require('utils.blink').use_kind_name('${name}')";
          in {
            buffer.min_keyword_length = 5;
            snippets.min_keyword_length = 3;

            copilot = lib.mkIf config.modules.copilot.enable {
              async = true;
              name = "copilot";
              module = "blink-copilot";
              score_offset = 100;
              opts = {
                max_completions = 1;
                max_attempts = 2;
                debounce = 100;
                auto_refresh = {
                  backward = false;
                  forward = false;
                };
              };
            };

            ripgrep = {
              async = true;
              name = "ripgrep";
              module = "blink-ripgrep";
              score_offset = -100;
              opts = {
                project_root_marker = []; # always use cwd
                search_casing = "--smart-case";
              };
            };

            calc = {
              async = true;
              name = "calc";
              module = "blink.compat.source";
              score_offset = -10;
              transform_items = useKindName "Calc";
            };

            dap = {
              name = "dap";
              module = "blink.compat.source";
              transform_items = useKindName "DAP";
            };
          };
        };

        signature.enabled = true;

        completion = {
          list.selection = {
            preselect = false;
            auto_insert = true;
          };

          menu = {
            border = "rounded";
            auto_show = true;
            scrolloff = 3;

            min_width = 20;
            max_height = helpers.mkRaw "math.floor(vim.o.lines / 2)";

            draw = {
              gap = 2;
              padding = [1 2];

              columns = [
                ["kind_icon"]
                ["label"]
              ];

              components = {
                label = {
                  text = helpers.mkRaw "require('utils.blink').colorize_text";
                  highlight = helpers.mkRaw "require('utils.blink').colorize_highlights";
                };
              };
            };
          };

          documentation = {
            window.border = "rounded";
            auto_show = true;
            auto_show_delay_ms = 0;
          };
        };

        cmdline = {
          enabled = true;
          keymap = {
            preset = "inherit";

            "<Esc>" = [
              (helpers.mkRaw "require('utils.blink').actions.hide_and_leave_insert")
              (helpers.mkRaw "require('utils.blink').actions.cmdline_fallback")
            ];
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
          };
          completion = {
            menu.auto_show = true;
            list.selection = {
              preselect = false;
              auto_insert = true;
            };
          };
        };

        appearance = {
          use_nvim_cmp_as_default = true;

          kind_icons = {
            Event = "";
            Keyword = "󰌆";
            Operator = "󱓉";
            Reference = "";
            Snippet = "";
            TypeParameter = "󱗽";
            Unit = "";
            Variable = "󰆧";

            Calc = "";
            DAP = "";
            Unicode = "󰻐";
          };
        };

        keymap = {
          # https://cmp.saghen.dev/configuration/keymap.html#commands
          # https://github.com/Saghen/blink.cmp/blob/main/lua/blink/cmp/init.lua

          preset = "enter";

          "<Tab>" = [
            "snippet_forward"
            (helpers.mkRaw "require('utils.blink').actions.select_next_or_indent")
            "fallback"
          ];
          "<S-Tab>" = [
            "snippet_backward"
            "select_prev"
            "fallback"
          ];
          "<Down>" = [
            (helpers.mkRaw "require('utils.blink').actions.select_next_and_wrap_if_in_list")
            "fallback"
          ];
          "<Up>" = [
            (helpers.mkRaw "require('utils.blink').actions.select_prev_and_wrap_if_in_list")
            "fallback"
          ];
          "<C-Space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
            "hide"
            "fallback"
          ];
          "<Esc>" = [
            (helpers.mkRaw "require('utils.blink').actions.cancel_and_leave_insert")
            (helpers.mkRaw "require('utils.blink').actions.hide_and_leave_insert")
            "fallback"
          ];
        };
      };
    };

    blink-copilot.enable = lib.mkIf config.modules.copilot.enable true;
    blink-cmp-dictionary.enable = true;
    blink-ripgrep.enable = true;

    blink-compat = {
      enable = true;
      settings.impersonate_nvim_cmp = true;
    };

    cmp-calc.enable = true;
    cmp-dap.enable = true;
  };

  extraPackages = with pkgs; [
    ripgrep
  ];

  extraLuaPackages = rocks:
    with rocks; [
      luautf8
    ];
}
