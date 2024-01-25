_:

{
  keymaps = [
    {
      key = "<leader>r";
      action = "<CMD>SnipRun<CR>";
      mode = "n";
    }
    {
      key = "<leader>r";
      action = ":SnipRun<CR>";
      mode = "v";
    }
    {
      key = "<leader>R";
      action = "<CMD>%SnipRun<CR>";
    }
  ];

  plugins.sniprun.enable = true;
}
