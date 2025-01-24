{ config, lib, pkgs, utils, ... }:

{
  options.modules.typst.enable = lib.mkEnableOption "typst";

  config = lib.mkIf config.modules.typst.enable {
    plugins.typst-vim.enable = true;

    extraPlugins = with pkgs.vimPlugins; [{
      plugin = typst-preview;
      config = utils.luaToViml ''require("typst-preview").setup()'';
    }];

    # https://www.dogeystamp.com/typst-notes/
    extraConfigVim = ''
      function TypstWatch()
        vsp
        vertical resize 20
        exec 'terminal ' .. 'typst watch ' .. expand("%:")
        exec "norm \<c-w>h"
      endfunc

      function TypstPreview()
        call TypstWatch()
        silent exec "!${pkgs.zathura}/bin/zathura --fork " . expand("%:p:r") . ".pdf &"
      endfunc
    '';

    keymaps = [{
      key = "<leader,>";
      action = "<CMD>Telescope aerial<CR>";
    }];

    files."ftplugin/typst.lua" = {
      opts = {
        wrap = true;
        breakindent = true;
        linebreak = true;
        # breakindentopt = "br,list:-1";
      };
    };
  };
}

