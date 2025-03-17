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
      treesitter-context = {
        enable = true;
        settings = {
          line_numbers = true;
          max_lines = 3;
          trim_scope = "outer";
          min_window_height = 25;
          multiline_threshold = 1;
        };
      };
      treesitter-refactor.enable = true;
      treesitter-textobjects.enable = true;
    };
  };
}
