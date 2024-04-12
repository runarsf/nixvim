_:

{
  plugins.mini = {
    enable = true;
    modules = {
      pairs = { };
      comment = { };
      align = { };
      # hipatterns = { };
      bufremove = { };
      move = { };
      trailspace = { };
      tabline = { };
      files = {
        # TODO Multiple mappings https://github.com/echasnovski/mini.nvim/discussions/409
        #  Enter / e for go_in
        mappings = {
          go_in_plus  = "<Right>";
          go_out_plus = "<Left>";
          synchronize = "W";
        };
      };
    };
  };

  extraConfigVim = ''
    function DoIfEmpty()
      if @% == ""
        lua MiniFiles.open()
      " elseif filereadable(@%) == 0
      "   echom "new file"
      " elseif line('$') == 1 && col('$') == 1
      "   echom "file is empty"
      endif
    endfunction
  '';

  autoCmd = [
    { # Open files if vim started with no arguments
      event = [ "VimEnter" ];
      pattern = [ "*" ];
      command = "call DoIfEmpty()";
    }
  ];

  keymaps = [
    {
      key = "<C-n>";
      action = "<CMD>lua MiniFiles.open()<CR>";
      options.desc = "Open file browser";
    }
  ];
}
