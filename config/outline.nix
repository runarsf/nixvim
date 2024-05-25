{ pkgs, lib, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = outline-nvim;
      config = lib.luaToViml ''require("outline").setup()'';
    }
  ];

  keymaps = [
    {
      key = "<leader>o";
      action = "<CMD>Outline<CR>";
      options.desc = "Toggle outline";
    }
  ];
}
