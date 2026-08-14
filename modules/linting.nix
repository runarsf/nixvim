{
  lib,
  config,
  ...
}:
lib.mkModule config "linting" {
  plugins.lint = {
    enable = true;

    autoCmd.event = [
      "BufReadPost"
      "BufWritePost"
      "InsertLeave"
    ];
  };
}
