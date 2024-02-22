{ pkgs, ... }:

{
  colorschemes.ayu = {
    enable = true;
    package = pkgs.vimPlugins.neovim-ayu;
  };
}
