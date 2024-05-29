{ pkgs, lib, ... }:

{
  extraConfigVim =
    lib.concatStringsSep "\n" [ (builtins.readFile ./folds.vim) ];

  keymaps = [{
    key = "zF";
    action = "<CMD>call AutoFold()<CR>";
    options.desc = "Toggle auto fold";
  }];

  # TODO https://github.com/AdamWagner/stackline/issues/42
  # FIXME https://github.com/anuvyklack/pretty-fold.nvim/issues/38
  # extraPlugins = [{
  #   plugin = pkgs.vimPlugins.pretty-fold-nvim;
  #   config = lib.luaToViml ''
  #     require("pretty-fold").setup({
  #       keep_indentation = false,
  #       fill_char = ' ',
  #       sections = {
  #         left = {
  #           function() return string.rep(' ', vim.fn.indent(vim.v.foldstart)) end, '»', 'content', function() return string.rep('›', vim.v.foldlevel - 1) end
  #         },
  #         right = {
  #           '{ ', 'number_of_folded_lines', ' }  ',
  #         }
  #       }
  #     })
  #   '';
  # }];
}
