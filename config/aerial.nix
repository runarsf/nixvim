{ pkgs, lib, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = aerial-nvim;
      config = lib.luaToViml ''
        require("aerial").setup();
        require("telescope").load_extension("aerial")
      '';
    }
  ];

  keymaps = [
    {
      key = "<C-l>";
      action = "<CMD>Telescope aerial<CR>";
    }
    {
      key = "<leader>o";
      action = "<CMD>AerialToggle<CR>";
      options.desc = "Toggle outline";
    }
  ];
}
