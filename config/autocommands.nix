{
  extraConfigVim = ''
    function s:ForbidReplace()
      if v:insertmode isnot# 'i'
        call feedkeys("\<Insert>", "n")
      endif
    endfunction
  '';

  autoGroups = { CursorLine.clear = true; ForbidReplaceMode.clear = true; };

  autoCmd = [
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
    {
      event = [ "InserEnter" "InsertChange" ];
      pattern = [ "*" ];
      command = "call s:ForbidReplace()";
      group = "ForbidReplaceMode";
    }
  ];
}
