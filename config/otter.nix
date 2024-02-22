{ pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = otter-nvim;
      config = ''lua require("otter").setup()'';
    }
  ];

  plugins.nvim-cmp.sources = [
    { name = "otter"; }
  ];
}
