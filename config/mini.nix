{
  plugins.mini = {
    enable = true;
    modules = {
      pairs = { };
      comment = { };
      align = { };
      hipatterns = { };
      bufremove = { };
      # animate = { };
      # tabline = { };
      files = {
        # TODO Multiple mappings https://github.com/echasnovski/mini.nvim/discussions/409
        #  Enter / e for go_in
        mappings = {
          go_in_plus  = "<Right>";
          go_out_plus = "<Left>";
          synchronize = "W";
        };
      };
    };
  };
}
