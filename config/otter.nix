{ pkgs, lib, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = otter-nvim;
      config = lib.luaToViml ''require("otter").setup()'';
    }
  ];

  plugins.cmp.settings.sources = [
    { name = "otter"; }
  ];
}
