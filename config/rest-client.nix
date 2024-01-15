{ pkgs, ... }: {
  extraPlugins = [ pkgs.vimPlugins.rest-nvim ];
  keymaps = [
    {
      key = "<leader>r";
      action = "<Plug>RestNvim";
    }
    {
      key = "<leader>rc";
      action = "<Plug>RestNvimPreview";
    }
    {
      key = "<leader>r.";
      action = "<Plug>RestNvimLast";
    }
  ];
}
