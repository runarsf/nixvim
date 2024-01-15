# TODO
{ pkgs, ... }: {
  extraPlugins = with pkgs.vimPlugins; [{
    plugin = pretty-fold-nvim;
    config = ''
      lua require("pretty-fold").setup({
        sections = {
          left = {
            'content'
          }
        }
      })
    '';
  }];
}
