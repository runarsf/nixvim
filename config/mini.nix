{ helpers, ... }:

{
  plugins.mini = {
    enable = true;
    modules = {
      pairs = { };
      comment = { };
      align = { };
      # hipatterns = { };
      surround = { };
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
        windows = {
          preview = true;
          width_preview = 50;
        };
      };
    };
  };

  autoCmd = [
    { # Open files if vim started with no arguments
      event = [ "VimEnter" ];
      pattern = [ "*" ];
      callback = helpers.mkRaw ''
        function()
          if (vim.fn.expand("%") == "") then
            MiniFiles.open()
          -- elseif filereadable(@%) == 0
          --   echom "new file"
          -- elseif line('$') == 1 && col('$') == 1
          --   echom "file is empty"
          end
        end
      '';
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
