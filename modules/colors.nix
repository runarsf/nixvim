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

  # keymaps = with lib.utils.keymaps; [
  #   (mkKeymap' "<Leader>c" (lib.nixvim.mkRaw ''
  #     function()
  #       require('minty.huefy').open( { border = true } )
  #     end
  #   '') "Color picker")
  # ];

  # extraPlugins = with pkgs.vimPlugins; [
  #   nvchad-volt
  #   nvchad-menu
  #   nvchad-minty
  # ];
}
