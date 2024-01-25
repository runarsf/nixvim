{ pkgs, ... }:

{
  extraPlugins = [{
    plugin = pkgs.vimPlugins.rest-nvim;
    config = ''
      lua require("rest-nvim").setup({
      \   skip_ssl_verification = true,
      \ })
    '';
  }];
  keymaps = [
    {
      key = "<leader>h";
      action = "<Plug>RestNvim";
    }
    {
      key = "<leader>hc";
      action = "<Plug>RestNvimPreview";
    }
    {
      key = "<leader>h.";
      action = "<Plug>RestNvimLast";
    }
  ];
}
