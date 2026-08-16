{
  config,
  lib,
  ...
}: let
  indentchar = "▏";
  colchar = "▕";
  icons = {
    trace = "";
    debug = "";
    info = "";
    warn = "";
    error = "";
  };
in
  lib.mkModule config "ui" {
    highlightOverride = {
      SnacksNotifierError = {
        fg = "#C24747";
        bg = "#4C1313";
      };
      SnacksNotifierWarn = {
        fg = "#C27A47";
        bg = "#4C2B13";
      };
      SnacksNotifierInfo = {
        fg = "#47A3C2";
        bg = "#133E4C";
      };
      SnacksNotifierDebug.fg = "#636A72";
      SnacksNotifierTrace.fg = "#636A72";
    };

    plugins = {
      nui.enable = true;

      noice = {
        enable = true;
        settings = {
          cmdline = {
            enabled = true;
            format.find_and_replace = {
              title = " Find & replace ";
              icon = "󰛔";
              pattern = "^:%%s/";
              lang = "regex";
            };
          };

          messages.view = "notify";
          notify.view = "notify";

          lsp.progress = {
            enabled = true;
            view = "mini";
          };

          lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };

          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
            inc_rename = true;
            lsp_doc_border = true;
          };

          views.notify.replace = false;
        };
        luaConfig.post =
          # lua
          ''
            local ok, telescope = pcall(require, "telescope")
            if ok then
              telescope.load_extension("noice")
            end
          '';
      };

      numbertoggle.enable = true;

      virt-column = {
        enable = true;
        settings = {
          char = colchar;
          virtcolumn = "80,100,120";
        };
      };

      snacks = {
        enable = true;
        settings = {
          indent = {
            enabled = true;
            animate.enabled = false;
            indent.char = indentchar;
            scope.char = indentchar;
          };

          notifier = {
            inherit icons;
            enabled = true;
            style = lib.nixvim.mkRaw ''
              function(buf, notif, ctx)
                ctx.opts.border = "none"
                local lines = vim.split(notif.msg, "\n")
                lines[1] = notif.icon .. " " .. lines[1]
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                vim.api.nvim_buf_set_extmark(buf, ctx.ns, 0, 0, {
                  end_col = #notif.icon,
                  hl_group = ctx.hl.icon,
                })
              end
            '';
            top_down = false;
            margin.right = 0;
          };
        };
      };
    };

    keymaps = lib.optionals config.modules.telescope.enable (with lib.utils.keymaps; [
      # NOTE: was `require('pickers').notifications()` (still defined in
      # modules/telescope/pickers.lua, just unbound) before noice.nvim came
      # back — noice's own telescope extension covers the same ground now.
      (mkKeymap' "<Leader>n" (lib.nixvim.mkRaw ''
        function()
          require('lz.n').trigger_load('telescope.nvim')
          require('telescope').extensions.noice.noice()
        end
      '') "Notification & message history")
    ]);
  }
