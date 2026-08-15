{
  config,
  lib,
  ...
}: let
  indentchar = "▏";
  colchar = "▕";
in
  lib.mkModule config "ui" {
    # Native, experimental (per Neovim's own doc comment) replacement for the
    # classic hit-enter-prompt message UI, needed because cmdheight = 0 forces
    # a blocking prompt for any message otherwise (see config/options.nix).
    # Routes messages to an ephemeral auto-dismissing window instead of the
    # cmdline. Doesn't affect vim.notify()-based messages (LSP progress via
    # fidget, plugins that already call vim.notify), which nvim-notify below
    # renders directly, bypassing this entirely.
    extraConfigLua =
      # lua
      ''
        require('vim._core.ui2').enable({
          msg = {
            targets = 'msg',
            msg = { timeout = 3000 },
          },
        })
      '';

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

      fidget.enable = true;

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
      #     draw.animation = lib.nixvim.mkRaw "require('mini.indentscope').gen_animation.none()";
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

    keymaps = lib.optionals config.modules.telescope.enable (with lib.utils.keymaps; [
      (mkKeymap' "<Leader>n" (lib.nixvim.mkRaw ''
        function()
          require('lz.n').trigger_load('telescope.nvim')
          require('pickers').notifications()
        end
      '') "Notification & message history")
    ]);
  }
