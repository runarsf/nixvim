{
  config,
  lib,
  ...
}:
lib.mkModule config "treesitter" {
  extraConfigLuaPost = ''
    -- Prevent LSP from overwriting treesitter color settings
    -- https://github.com/NvChad/NvChad/issues/1907
    vim.highlight.priorities.semantic_tokens = 95
  '';

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
}
