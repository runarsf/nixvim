{
  config,
  lib,
  pkgs,
  ...
}:
# TODO https://github.com/OXY2DEV/foldtext.nvim
{
  options.modules.folds.enable = lib.mkEnableOption "folds";

  config = lib.mkIf config.modules.folds.enable {
    extraConfigVim =
      lib.concatStringsSep "\n" [(builtins.readFile ./folds.vim)];

    keymaps = [
      {
        key = "zF";
        action = "<CMD>call AutoFold()<CR>";
        options.desc = "Toggle auto fold";
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = pretty-fold;
        config = lib.utils.viml.fromLua ''
          require("pretty-fold").setup({
            keep_indentation = false,
            fill_char = ' ',
            sections = {
              left = {
                function() return string.rep(' ', vim.fn.indent(vim.v.foldstart)) end, '»', 'content', function() return string.rep('›', vim.v.foldlevel - 1) end
              },
              right = {
                '{ ', 'number_of_folded_lines', ' }  ',
              }
            }
          })
        '';
      }
    ];
  };
}
