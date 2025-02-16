{
  config,
  utils,
  pkgs,
  lib,
  ...
}: {
  options.modules.colorscheme.sequoia.enable = lib.mkEnableOption "sequoia";

  config = lib.mkIf config.modules.colorscheme.sequoia.enable {
    colorscheme = "sequoia";

    extraPlugins = with pkgs.vimPlugins; [sequoia-moonlight-nvim];
  };
}
