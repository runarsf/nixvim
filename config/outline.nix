{ pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = outline-nvim;
      config = ''lua require("outline").setup { }'';
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
