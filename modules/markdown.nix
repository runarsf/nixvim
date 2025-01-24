{ config, lib, pkgs, utils, ... }:

{
  options.modules.markdown.enable = lib.mkEnableOption "markdown";

  config = lib.mkIf config.modules.markdown.enable {
    plugins = {
      glow = {
        enable = true;
        settings = {
          border = "rounded";
          height = 1000;
          width = 1000;
          height_ratio = 1.0;
          width_ratio = 1.0;
        };
      };
      markview.enable = true;
      helpview.enable = true;
    };

    files."ftplugin/markdown.lua" = {
      opts = {
        conceallevel = 2;
        wrap = true;
      };
    };
  };
}

