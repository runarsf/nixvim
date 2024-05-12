_:

{
  extraConfigVim = ''
    function ForbidReplace()
      if v:insertmode isnot# 'i'
        call feedkeys("\<Insert>", "n")
      endif
    endfunction

    function DisableSyntax()
      echo("Big file, disabling syntax, treesitter and folding")
      if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
      endif

      set foldmethod=manual
      syntax clear
      syntax off
      filetype off
      set noundofile
      set noswapfile
      set noloadplugins
    endfunction
  '';

  autoGroups = {
    CursorLine.clear = true;
    ForbidReplaceMode.clear = true;
    BigFile.clear = true;
  };

  autoCmd = [
    { # Disable syntax, treesitter, and folding for big files
      group = "BigFile";
      event = [ "BufWinEnter" "BufReadPre" "FileReadPre" ];
      pattern = [ "*" ];
      command = "if getfsize(expand('%')) > 512 * 1024 | exec DisableSyntax() | endif";
    }
    # {
    #   event = [ "CursorMoved", "CursorMovedI " ];
    #   pattern = [ "*" ];
    #   command = "if col('.') >= 80 | echo 'hi' | endif";
    # }
    { # Show cursor-line
      group = "CursorLine";
      event = [ "InsertLeave" "WinEnter" ];
      pattern = [ "*" ];
      command = "silent! set cursorline";
    }
    { # Hide cursor-line
      group = "CursorLine";
      event = [ "InsertEnter" "WinLeave" ];
      pattern = [ "*" ];
      command = "silent! set nocursorline";
    }
    { # Check if file has been modified on disk
      event = [ "FocusGained" "CursorHold" ];
      pattern = [ "*" ];
      command = "checktime";
    }
    { # Get rid of the pesky cmd window
      event = [ "CmdwinEnter" ];
      pattern = [ "*" ];
      command = "q";
    }
    { # Disable automatic commenting on newline
      event = [ "FileType" "BufNewFile" "BufRead" ];
      pattern = [ "*" ];
      command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o";
    }
    { # Forbid replace mode
      event = [ "InsertEnter" "InsertChange" ];
      pattern = [ "*" ];
      command = "call ForbidReplace()";
      group = "ForbidReplaceMode";
    }
  ];
}
