_:

{
  plugins = {
    zen-mode = {
      enable = true;
      settings = {
      };
    };
    twilight.enable = true;
    twilight.settings.context = 6;
  };
  # FIXME Transparent dimmed area https://github.com/folke/zen-mode.nvim/issues/70#issuecomment-1329927620


  keymaps = [
    {
      key = "<leader>z";
      action = "<CMD>ZenMode<CR>";
      mode = "n";
    }
  ];
}
