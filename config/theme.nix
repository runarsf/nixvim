{ pkgs, ... }: {
  colorscheme = "ayu-dark";
  colorschemes.ayu = {
    enable = true;
    package = pkgs.vimPlugins.neovim-ayu;
    # overrides = {
    #   Normal = { bg = "None"; };
    #   ColorColumn = { bg = "None"; };
    #   SignColumn = { bg = "None"; };
    #   Folded = { bg = "None"; };
    #   FoldColumn = { bg = "None"; };
    #   TabLine = { bg = "None"; };
    #   TabLineFill = { bg = "None"; };
    #   TabLineSel.bg = "None";
    #   Title.bg = "None";
    #   NotifyBackground.bg = "#000000";
    #   CursorLine = { bg = "None"; };
    #   CursorColumn = { bg = "None"; };
    #   WhichKeyFloat = { bg = "None"; };
    #   VertSplit = { bg = "None"; };
    # };
  };
}
