{ pkgs, lib, ... }:

{
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

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = markview-nvim;
      config = lib.luaToViml ''require("markview").setup()'';
    }
  ];
}
