_:

{
  plugins.cloak.enable = true;

  keymaps = [
    {
      key = "<leader>ht";
      action = "<CMD>CloakToggle<CR>";
      options.desc = "Toggle character cloaking";
    }
    {
      key = "<leader>hp";
      action = "<CMD>CloakPreviewLine<CR>";
      options.desc = "Preview cloaked line";
    }
  ];
}
