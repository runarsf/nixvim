{
  config,
  lib,
  ...
}: let
  # TODO Set lualine theme?
  # TODO Get colors from generated theme (see ayu.colors.generate())
  # color = name: helpers.mkRaw "ayu_colors.${name}";
  accent = "#E6B450";
  guide_normal = "#1E222A";
  guide_active = "#3C414A";
in
  lib.mkModule' config ["colorschemes" "ayu"] config.modules.colorschemes.all.enable {
    highlight = {
      IndentLine.fg = guide_normal;
      IndentLineCurrent.fg = accent;
    };
    colorschemes.ayu = {
      enable = true;

      # :lua print(vim.inspect(require('ayu.colors')))
      settings.overrides = lib.mkIf config.modules.colorschemes.transparent {
        Normal.bg = "None";
        NormalFloat.bg = "None";
        ColorColumn.bg = "None";
        SignColumn.bg = "None";
        Folded.bg = "None";
        FoldColumn.bg = "None";
        VertSplit.bg = "None";
        LineNr.fg = guide_active;
      };
    };

    plugins.notify.settings.background_colour = lib.mkIf config.modules.colorschemes.transparent "#0f1419";
  }
