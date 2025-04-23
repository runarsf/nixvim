{
  config,
  lib,
  ...
}:
lib.mkModule config "otter" {
  plugins.otter = {
    enable = true;
    settings.handle_leading_whitespace = true;
  };
}
