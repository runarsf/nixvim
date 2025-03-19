{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "typst" {
  plugins = {
    lsp.servers = {
      tinymist.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.typst = ["typstfmt"];
    };

    typst-vim.enable = true;
  };

  files."ftplugin/typst.lua" = {
    opts = {
      wrap = true;
      breakindent = true;
      linebreak = true;
      # breakindentopt = "br,list:-1";
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = typst-preview;
      config = lib.utils.viml.fromLua ''require("typst-preview").setup()'';
    }
  ];

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
      silent exec "!${lib.getExe pkgs.zathura} --fork " . expand("%:p:r") . ".pdf &"
    endfunc
  '';
}
