# TODO
{ pkgs, ... }: {
  extraPlugins = with pkgs.vimPlugins; [{
    plugin = pretty-fold-nvim;
    config = ''lua require("pretty-fold").setup()'';
    # config = ''
    #   lua require("pretty-fold").setup({
    #     sections = {
    #       left = {
    #         'content'
    #       }
    #     }
    #   })
    # '';
    /* opts = {
         keep_indentation = false,
         fill_char = ' ',
         sections = {
           left = {
             '»', 'content', function() return string.rep('›', vim.v.foldlevel - 1) end
           },
           right = {
             '{ ', 'number_of_folded_lines', ' }  ',
           }
         }
       },
    */
  }];
}
