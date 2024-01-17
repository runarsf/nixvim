{ pkgs, ... }: {
  extraPlugins = [{
    plugin = pkgs.vimPlugins.rest-nvim;
    # FIXME Config doesn't apply correctly (for all extraPlugins)
    # config = ''
    #   require("rest-nvim").setup({
    #     skip_ssl_verification = true,
    #   })
    # '';
  }];
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
