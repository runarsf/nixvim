{ config, lib, ... }:

{
  options.modules.colors.enable = lib.mkEnableOption "colors";

  config = lib.mkIf config.modules.colors.enable {
    plugins.nvim-colorizer.enable = true;

    plugins.ccc = {
      enable = true;
      settings = { highlighter.auto_enable = false; };
    };
  };
}
