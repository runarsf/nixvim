{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule' config ["colorschemes" "sequoia"] config.modules.colorschemes.all.enable {
  colorscheme = "sequoia";

  extraPlugins = with pkgs.vimPlugins; [sequoia-moonlight-nvim];
}
