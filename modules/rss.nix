{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule config "rss" {
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = feed-nvim;
      config = lib.utils.viml.fromLua ''
        require("feed").setup({})
      '';
    }
  ];
}
