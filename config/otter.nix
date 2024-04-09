{ pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = otter-nvim;
      config = ''lua require("otter").setup()'';
    }
  ];

  plugins.cmp.settings.sources = [
    { name = "otter"; }
  ];
}
