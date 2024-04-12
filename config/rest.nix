{ ... }:

{
  plugins.rest.enable = true;

  keymaps = [
    {
      key = "<leader>rr";
      action = "<CMD>Rest run<CR>";
      options.desc = "(rest) Run";
    }
    {
      key = "<leader>h.";
      action = "<CMD>Run last http<CR>";
      options.desc = "(rest) Run last";
    }
  ];
}
