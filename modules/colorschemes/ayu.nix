# TODO: blink-cmp highlights https://github.com/Shatur/neovim-ayu/issues/50
{
  config,
  lib,
  ...
}: let
  # TODO Get colors from generated theme (see ayu.colors.generate())
in
  lib.utils.mkColorschemeModule config "ayu" {
    colorschemes.ayu = {
      enable = true;

      # :lua print(vim.inspect(require('ayu.colors')))
      settings.overrides =
        #local colors = require('ayu.colors')
        #colors.generate()
        {
          BlinkCmpMenu.bg = "None";
          BlinkCmpMenuBorder.bg = "None";
          BlinkCmpDoc.bg = "None";
          BlinkCmpDocBorder.bg = "None";
          Pmenu.bg = "None";
          LineNr.fg = "#3C414A";
          IndentLine.fg = "#1E222A";
          IndentLineCurrent.fg = "#E6B450";
        }
        // lib.optionalAttrs config.modules.colorschemes.transparent {
          # Normal.bg = "None";
          # NormalFloat.bg = "None";
          # ColorColumn.bg = "None";
          # SignColumn.bg = "None";
          # Folded.bg = "None";
          # FoldColumn.bg = "None";
          # VertSplit.bg = "None";
        };
    };

    # plugins.notify.settings.background_colour = lib.mkIf config.modules.colorschemes.transparent "#0f1419";
  }
