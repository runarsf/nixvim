{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule config "gremlins" {
  # https://vim.fandom.com/wiki/Highlight_unwanted_spaces
  extraPlugins = with pkgs.vimPlugins; [
    # vim-unicode-homoglyphs
    vim-troll-stopper
  ];
}
