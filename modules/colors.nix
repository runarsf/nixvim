{
  config,
  pkgs,
  lib,
  helpers,
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
  #   (mkKeymap' "<Leader>c" (helpers.mkRaw ''
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
