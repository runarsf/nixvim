{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkColorschemeModule config "jellybeans" {
  colorscheme = lib.mkDefault "jellybeans";

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = jellybeans-nvim;
      config = lib.utils.setup' "jellybeans";
    }
  ];
}
