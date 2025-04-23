{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkModule config "colors" {
  plugins = {
    colorizer.enable = true;

    ccc = {
      enable = true;
      settings.highlighter.auto_enable = false;
    };
  };

  keymaps = [
    {
      key = "<Leader>c";
      action = "<CMD>lua require('minty.huefy').open( { border = true } )<CR>";
      options.desc = "Color picker";
    }
  ];

  extraPlugins = with pkgs.vimPlugins; [
    nvchad-volt
    nvchad-menu
    nvchad-minty
  ];
}
