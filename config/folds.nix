{ pkgs, lib, ... }:

{
  extraConfigVim =
    lib.concatStringsSep "\n" [ (builtins.readFile ./folds.vim) ];

  keymaps = [{
    key = "<leader>A";
    action = "<CMD>call AutoFold()<CR>";
  }];

  extraPlugins = [{
    plugin = pkgs.vimPlugins.pretty-fold-nvim;
    config = ''
      lua require("pretty-fold").setup({
      \   keep_indentation = false,
      \   fill_char = ' ',
      \   sections = {
      \     left = {
      \       '»', 'content', function() return string.rep('›', vim.v.foldlevel - 1) end
      \     },
      \     right = {
      \       '{ ', 'number_of_folded_lines', ' }  ',
      \     }
      \   }
      \ })
    '';
  }];
}
