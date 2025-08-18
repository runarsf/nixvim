{
  config,
  lib,
  ...
}:
lib.mkModule config "terminal" {
  plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "float";
      open_mapping = "[[<M-n>]]";
      float_opts.border = "curved";
    };
  };
}
