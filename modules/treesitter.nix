{ config, lib, ... }:

{
  options.modules.treesitter.enable = lib.mkEnableOption "treesitter";

  config = lib.mkIf config.modules.treesitter.enable {
    # TODO Refactoring https://github.com/nvim-treesitter/nvim-treesitter-refactor
    plugins.treesitter = {
      enable = true;
      # indent = false;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
      };
    };
  };
}
