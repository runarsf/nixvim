{
  plugins.mini = {
    enable = true;
    modules = {
      pairs = { };
      comment = { };
      align = { };
      animate = { };
      hipatterns = { };
      bufremove = { };
      # tabline = { };
      files = {
        mappings = {
          go_in       = "<Right>";
          go_in_plus  = "<S-Right>";
          go_out      = "<Left>";
          go_out_plus = "<S-Left>";
          synchronize = "R";
        };
      };
    };
  };
}
