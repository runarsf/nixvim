{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkColorschemeModule config "cendre" {
  colorscheme = lib.mkDefault "cendre";

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = cendre;
      config = lib.utils.setup' "cendre";
    }
  ];
}
