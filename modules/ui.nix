{
  config,
  lib,
  helpers,
  ...
}: let
  indentchar = "▏";
  colchar = "▕";
in
  lib.mkModule config "ui" {
    plugins = {
      nui.enable = true;

      numbertoggle.enable = true;

      notify = {
        enable = true;

        settings = {
          # background_colour = "#000000";
          render = "compact";
          stages = "slide";
          top_down = false;
          fps = 60;
          timeout = 3000;
          max_width = 80;
          icons = {
            trace = "";
            debug = "";
            info = "";
            warn = "";
            error = "";
          };
        };
      };

      noice = {
        enable = true;
        settings = {
          messages.view = "mini";
          notify.view = "notify";

          lsp.progress = {
            enable = true;
            view = "mini";
          };

          cmdline.format.find_and_replace = {
            title = " Find & replace ";
            icon = "󰛔";
            pattern = "^:%%s/";
            lang = "regex";
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

      virt-column = {
        enable = true;
        settings = {
          char = colchar;
          virtcolumn = "80,100,120";
        };
      };

      # TODO: Improve. Look at the way lazy does it
      # mini = {
      #   enable = true;
      #   modules.indentscope = {
      #     symbol = char;
      #     draw.animation = helpers.mkRaw "require('mini.indentscope').gen_animation.none()";
      #   };
      # };
      snacks = {
        enable = true;
        settings.indent = {
          enabled = true;
          animate.enabled = false;
          indent.char = indentchar;
          scope.char = indentchar;
        };
      };
    };

    keymaps = with lib.utils.keymaps; [
      (mkKeymap' "<Leader>n" (helpers.mkRaw ''
        function()
          local ok, lz_n = pcall(require, 'lz.n')
          if ok then
            lz_n.trigger_load('telescope.nvim')
          end

          vim.cmd("Noice telescope")
        end
      '') "Message history")
    ];
  }
