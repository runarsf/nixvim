{
  config,
  lib,
  ...
}:
lib.mkModule config "virt-column" {
  plugins.virt-column = {
    enable = true;
    settings = {
      char = "▕";
      virtcolumn = "80,100,120";
    };
  };
}
