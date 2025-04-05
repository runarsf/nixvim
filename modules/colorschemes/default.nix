{ lib, ... }:
{
  options = {
    modules.colorschemes.all.enable = lib.mkEnableOption "all configured colorschemes";
    modules.colorschemes.transparent = lib.mkEnableOption "transparent colorscheme background";
  };
}
