{ config, lib, pkgs, ... }:

{
  options.modules.markdown.enable = lib.mkEnableOption "markdown";

  config = lib.mkIf config.modules.markdown.enable {
    plugins.glow = {
      enable = true;
      settings = {
        border = "rounded";
        height = 1000;
        width = 1000;
        height_ratio = 1.0;
        width_ratio = 1.0;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [{
      plugin = markview-nvim;
      config = lib.luaToViml ''require("markview").setup()'';
    }];
  };
}
