{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkColorschemeModule config "sequoia" {
  colorscheme = "sequoia";

  extraPlugins = with pkgs.vimPlugins; [sequoia-moonlight-nvim];
}
