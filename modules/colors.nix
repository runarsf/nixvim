{
  config,
  pkgs,
  lib,
  ...
}: {
  options.modules.colors.enable = lib.mkEnableOption "colors";

  config = lib.mkIf config.modules.colors.enable {
    plugins = {
      colorizer.enable = true;

    ccc = {
      enable = true;
      settings.highlighter.auto_enable = false;
    };
  };

    keymaps = [
      {
        key = "<leader>c";
        action = "<CMD>lua require('minty.huefy').open( { border = true } )<CR>";
        options.desc = "Color picker";
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      nvchad-volt
      nvchad-menu
      nvchad-minty
    ];
  };
}
