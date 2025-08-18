{
  config,
  pkgs,
  lib,
  ...
}: {
  globals = {
    mapleader = ",";
    maplocalleader = " ";
  };

  # extraConfigVim = ''
  #   function! CloseVimOrDeleteBuffer()
  #     " Check if there is only one tab open
  #     if tabpagenr('$') == 1
  #       " Check how many buffers are visible in the current tab
  #       let l:visible_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
  #       " Close Vim if this is the only visible buffer in the last tab
  #       if l:visible_buffers == 1
  #         quit
  #       else
  #         BufferClose
  #       endif
  #     else
  #       BufferClose
  #     endif
  #   endfunction
  # '';

  # TODO Keymap for Sleuth to re-guess
  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "D" ''"_d'' "Delete without yanking")
    (mkKeymap' "DD" ''"_dd'' "Delete line without yanking")
    (mkKeymap' "X" ''"_x'' "Delete under without yanking")
    (mkKeymap' "<Leader>s" ":%!sort<CR>" "Sort lines")
    (mkKeymap' "<Leader><Space>" "<CMD>nohlsearch<CR>" "Unhighlight matches")

    # (mkKeymap' "Q" "@q" "Run macro")

    # {
    #   # TODO Move to keymapsOnEvents
    #   #  Waiting for: https://github.com/nix-community/nixvim/issues/2359
    #   #  Information: https://github.com/expipiplus1/update-nix-fetchgit?tab=readme-ov-file#from-vim
    #   key = "<Leader>U";
    #   action = ''
    #     :call Preserve("%!${pkgs.update-nix-fetchgit}/bin/update-nix-fetchgit --location=" . line(".") . ":" . col("."))<CR>'';
    #   options.desc = "Update fetcher under cursor";
    #   options.nowait = true;
    # }
  ];
}
