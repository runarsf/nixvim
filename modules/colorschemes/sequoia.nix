{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.colorschemes.sequoia.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.modules.colorschemes.all.enable;
    description = "sequoia";
  };

  config = lib.mkIf config.modules.colorschemes.sequoia.enable {
    colorscheme = "sequoia";

    extraPlugins = with pkgs.vimPlugins; [ sequoia-moonlight-nvim ];
  };
}
