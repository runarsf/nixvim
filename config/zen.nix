_:

{
  plugins = {
    zen-mode.enable = true;
    twilight.enable = true;
    twilight.settings.context = 6;
  };

  keymaps = [
    {
      key = "<leader>z";
      action = "<CMD>ZenMode<CR>";
      mode = "n";
    }
  ];
}
