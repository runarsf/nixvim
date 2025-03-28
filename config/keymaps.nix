{
  config,
  pkgs,
  ...
}: {
  globals = {
    mapleader = ",";
    maplocalleader = " ";
  };

  # TODO Refactor to use mkKeymap

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
  #
  #   function! Preserve(command)
  #     " Preserve the cursor location with filters
  #     " https://github.com/expipiplus1/update-nix-fetchgit?tab=readme-ov-file#from-vim
  #     let w = winsaveview()
  #     execute a:command
  #     call winrestview(w)
  #   endfunction
  # '';

  keymaps = [
    # {
    #   key = " ";
    #   action = "<Nop>";
    #   mode = ["n" "v"];
    #   options.desc = "No action";
    # }
    {
      key = "D";
      action = ''"_d'';
      mode = ["n" "v"];
      options.desc = "Delete";
    }
    {
      key = "DD";
      action = ''"_dd'';
      mode = ["n" "v"];
      options.desc = "Delete line";
    }
    {
      key = "X";
      action = ''"_x'';
      mode = ["n" "v"];
      options.desc = "Delete under";
    }
    {
      key = "<Leader>s";
      action = ":%!sort<CR>";
      mode = ["n" "v"];
      options.desc = "Sort lines";
    }
    {
      key = "<Leader><Space>";
      action = "<CMD>nohlsearch<CR>";
      options.desc = "Turn off highlighted matches";
    }
    {
      key = "<Leader>??";
      action =
        if (config.plugins.notify.enable)
        then "<CMD>Telescope notify<CR>"
        else "<CMD>messages<CR>";
      options.desc = "Show messages";
    }
    {
      key = "<Leader>?";
      action =
        if (config.plugins.notify.enable)
        then "<CMD>Notifications<CR>"
        else "<CMD>echo v:errmsg<CR>";
      options.desc = "Show last error message";
    }

    # Better window navigation
    {
      key = "<C-Left>";
      action = "<CMD>wincmd h<CR>";
      mode = "n";
      options.desc = "Focus window left";
    }
    {
      key = "<C-Down>";
      action = "<CMD>wincmd j<CR>";
      mode = "n";
      options.desc = "Focus window down";
    }
    {
      key = "<C-Up>";
      action = "<CMD>wincmd k<CR>";
      mode = "n";
      options.desc = "Focus window up";
    }
    {
      key = "<C-Right>";
      action = "<CMD>wincmd l<CR>";
      mode = "n";
      options.desc = "Focus window right";
    }

    # Better tab movement
    # {
    #   key = "<C-t>";
    #   action = "<CMD>tabnew<CR>";
    #   mode = "n";
    #   options.desc = "New tab";
    # }
    # {
    #   key = "<S-l>";
    #   action = "<CMD>BufferNext<CR>";
    #   mode = "n";
    #   options.desc = "Next buffer";
    # }
    # {
    #   key = "<S-h>";
    #   action = "<CMD>BufferPrevious<CR>";
    #   mode = "n";
    #   options.desc = "Previous buffer";
    # }

    # Better indents
    {
      key = "<";
      action = "<gv";
      mode = "x";
      options.desc = "Decrease indent";
    }
    {
      key = ">";
      action = ">gv";
      mode = "x";
      options.desc = "Increase indent";
    }
    {
      key = "<";
      action = "<<";
      mode = "n";
      options.desc = "Decrease indent";
    }
    {
      key = ">";
      action = ">>";
      mode = "n";
      options.desc = "Increase indent";
    }

    # Quickly move current line
    # https://github.com/mhinz/vim-galore#quickly-move-current-line
    # {
    #   key = "<A-j>";
    #   action = ":m .+1<CR>==";
    #   mode = "n";
    #   options.desc = "Move line down";
    # }
    # {
    #   key = "<A-k>";
    #   action = ":m .-2<CR>==";
    #   mode = "n";
    #   options.desc = "Move line up";
    # }
    # {
    #   key = "<A-j>";
    #   action = "<Esc>:m .+1<CR>==gi";
    #   mode = "i";
    #   options.desc = "Move line down";
    # }
    # {
    #   key = "<A-k>";
    #   action = "<Esc>:m .-2<CR>==gi";
    #   mode = "i";
    #   options.desc = "Move line up";
    # }
    # {
    #   key = "<A-j>";
    #   action = ":m '>+1<CR>gv=gv";
    #   mode = "v";
    #   options.desc = "Move line down";
    # }
    # {
    #   key = "<A-k>";
    #   action = ":m '<-2<CR>gv=gv";
    #   mode = "v";
    #   options.desc = "Move line up";
    # }

    {
      key = "<Leader>l";
      action = "<CMD>set cursorline!<CR>";
      options.desc = "Toggle cursorline";
    }
    {
      key = "<Leader>L";
      action = "<CMD>set cursorcolumn!<CR>";
      options.desc = "Toggle cursorcolumn";
    }

    # {
    #   key = "<Leader>q";
    #   action = "<CMD>call CloseVimOrDeleteBuffer()<CR>";
    #   options.desc = "Quit";
    # }
    # {
    #   key = "<Leader>Q";
    #   action = "<CMD>qa!<CR>";
    #   options.desc = "Quit all";
    # }
    {
      key = "<Leader>w";
      action = "<CMD>w<CR>";
      options.desc = "Write";
    }
    # {
    #   key = "<Leader>wq";
    #   action = "<CMD>w<CR><CMD>call CloseVimOrDeleteBuffer()<CR>";
    #   options.desc = "Write and quit";
    # }
    # {
    #   key = "<Leader>wr";
    #   action = "<CMD>set wrap!<CR>";
    #   options.desc = "Toggle word wrap";
    # }

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
