{ config, utils, pkgs, lib, ... }:

{
  options.modules.colorscheme.ayu.enable = lib.mkEnableOption "ayu";

  config = lib.mkIf config.modules.colorscheme.ayu.enable {
    colorscheme = "ayu";

    extraPlugins = with pkgs.vimPlugins; [ neovim-ayu ];
  };
}
