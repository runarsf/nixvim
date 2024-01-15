{ pkgs, ... }: {
  colorscheme = "ayu-dark";
  colorschemes.ayu = {
    enable = true;
    package = pkgs.vimPlugins.neovim-ayu;
  };
}
