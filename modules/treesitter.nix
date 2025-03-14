{
  config,
  lib,
  ...
}: {
  options.modules.treesitter.enable = lib.mkEnableOption "treesitter";

  config = lib.mkIf config.modules.treesitter.enable {
    # TODO Refactoring https://github.com/nvim-treesitter/nvim-treesitter-refactor
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
        };
      };
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
      treesitter-textobjects.enable = true;
    };
  };
}
