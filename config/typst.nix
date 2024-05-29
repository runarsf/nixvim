{ pkgs, lib, ... }:

{
  plugins.typst-vim.enable = true;

  extraPlugins = [
    {
      plugin = (pkgs.vimUtils.buildVimPlugin rec {
        name = "typst-preview.nvim";
        src = pkgs.fetchFromGitHub {
            owner = "chomosuke";
            repo = name;
            rev = "15eaaffc0a2d8cd871f485f399d1d67ed3322a0b";
            hash = "sha256-33clHm4XRfbYKSYrofm1TEaUV2UCIFVqNAc6Js8sTzY=";
        };
      });
      config = lib.luaToViml ''require("typst-preview").setup()'';
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
      silent exec "!zathura --fork " . expand("%:p:r") . ".pdf &"
    endfunc
  '';

  keymaps = [
    {
      key = "<leader,>";
      action = "<CMD>Telescope aerial<CR>";
    }
  ];

  # TODO Spellcheck
  # https://vi.stackexchange.com/a/36442
  files."ftplugin/typst.lua" = {
    opts = {
      wrap = true;
      breakindent = true;
      linebreak = true;
      # breakindentopt = "br,list:-1";
    };
  };
}
