{
  config,
  lib,
  ...
}:
lib.mkModule config "otter" {
  plugins.otter = {
    enable = true;

    settings = {
      lsp.diagnostic_update_events = [
        "BufReadPost"
        "BufWritePost"
        "InsertLeave"
      ];

      buffers = {
        preambles = {
          lua = [
            # lua
            "---@diagnostic disable: trailing-space, undefined-global, unreachable-code, unused-local"
          ];
        };
      };
    };
  };

  utils = [
    ./otter.lua
  ];
}
