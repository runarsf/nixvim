{
  lib,
  config,
  ...
}:
lib.mkModule config "linting" {
  plugins.lint = {
    enable = true;

    # FIXME: https://github.com/mfussenegger/nvim-lint/issues/235
    autoCmd.event = [
      "BufReadPost"
      "BufWritePost"
      "InsertLeave"
    ];
  };
}
