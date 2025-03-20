{
  config,
  lib,
  ...
}: {
  options.modules.colorschemes.ayu.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.modules.colorschemes.all.enable;
    description = "ayu";
  };

  config = lib.mkIf config.modules.colorschemes.ayu.enable {
    colorschemes.ayu = {
      enable = true;

      settings.overrides = lib.mkIf config.modules.colorschemes.transparent {
        Normal = {bg = "None";};
        NormalFloat = {bg = "None";};
        ColorColumn = {bg = "None";};
        SignColumn = {bg = "None";};
        Folded = {bg = "None";};
        FoldColumn = {bg = "None";};
        VertSplit = {bg = "None";};
        LineNr = {fg = "#3B404A";};
      };
    };

    plugins.notify.settings.background_colour = lib.mkIf config.modules.colorschemes.transparent "#0f1419";
  };
}
