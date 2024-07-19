_:

{
  # TODO Refactoring https://github.com/nvim-treesitter/nvim-treesitter-refactor
  plugins.treesitter = {
    enable = true;
    # indent = false;
    settings = {
      highlight = {
        additional_vim_regex_highlighting = false;
      };
    };
  };
}
