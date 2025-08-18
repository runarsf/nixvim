{
  config,
  lib,
  helpers,
  ...
}:
lib.mkModule config "mini" {
  plugins.mini = {
    enable = true;
    modules = {
      pairs = {};
      comment = {};
      align = {};
      surround = {};
      trailspace = {};
      move = {
        options = {
          reindent_linewise = true;
        };
        mappings = {
          left = "<M-Left>";
          down = "<M-Down>";
          up = "<M-Up>";
          right = "<M-Right>";

          line_left = "<M-Left>";
          line_down = "<M-Down>";
          line_up = "<M-Up>";
          line_right = "<M-Right>";
        };
      };
      files = {
        mappings = {
          go_in_plus = "<Right>";
          go_out_plus = "<Left>";
          synchronize = "W";
        };
        windows = {
          preview = true;
          width_preview = 50;
        };
      };
      icons = {};
    };
    mockDevIcons = true;
  };

  autoCmd = [
    {
      event = ["User"];
      pattern = ["MiniFilesBufferCreate"];
      callback = helpers.mkRaw ''
        function(args)
          local map_buf = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { buffer = args.data.buf_id })
          end

          local go_in_plus = function()
            for _ = 1, vim.v.count1 do
              MiniFiles.go_in({ close_on_file = true })
            end
          end

          map_buf('<Esc>', MiniFiles.close)
          map_buf('e', go_in_plus)
          map_buf('<CR>', go_in_plus)
          map_buf('w', MiniFiles.synchronize)
        end
      '';
    }
    /*
       {
      # Open files if vim started with no arguments
      event = ["VimEnter"];
      pattern = ["*"];
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
    */
  ];

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<C-n>" (helpers.mkRaw ''
        function()
          local files = require('mini.files')
          if not files.close() then
            -- files.open(vim.api.nvim_buf_get_name(0))
            files.open(files.get_latest_path())
          end
        end
    '') "File browser")

    (mkKeymap ["n"] "<M-h>" (helpers.mkRaw ''
      function()
        require('mini.move').move_line('left')
      end
    '') "Move left")
    (mkKeymap ["n"] "<M-j>" (helpers.mkRaw ''
      function()
        require('mini.move').move_line('down')
      end
    '') "Move down")
    (mkKeymap ["n"] "<M-k>" (helpers.mkRaw ''
      function()
        require('mini.move').move_line('up')
      end
    '') "Move up")
    (mkKeymap ["n"] "<M-l>" (helpers.mkRaw ''
      function()
        require('mini.move').move_line('right')
      end
    '') "Move right")

    (mkKeymap ["x"] "<M-h>" (helpers.mkRaw ''
      function()
        require('mini.move').move_selection('left')
      end
    '') "Move left")
    (mkKeymap ["x"] "<M-j>" (helpers.mkRaw ''
      function()
        require('mini.move').move_selection('down')
      end
    '') "Move down")
    (mkKeymap ["x"] "<M-k>" (helpers.mkRaw ''
      function()
        require('mini.move').move_selection('up')
      end
    '') "Move up")
    (mkKeymap ["x"] "<M-l>" (helpers.mkRaw ''
      function()
        require('mini.move').move_selection('right')
      end
    '') "Move right")
  ];
}


# TODO: Mapping to toggle dotfiles
#   local show_dotfiles = true
# 
#   local filter_show = function(fs_entry) return true end
# 
#   local filter_hide = function(fs_entry)
#     return not vim.startswith(fs_entry.name, '.')
#   end
# 
#   local toggle_dotfiles = function()
#     show_dotfiles = not show_dotfiles
#     local new_filter = show_dotfiles and filter_show or filter_hide
#     MiniFiles.refresh({ content = { filter = new_filter } })
#   end
# 
#   vim.api.nvim_create_autocmd('User', {
#     pattern = 'MiniFilesBufferCreate',
#     callback = function(args)
#       local buf_id = args.data.buf_id
#       -- Tweak left-hand side of mapping to your liking
#       vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
#     end,
#   })
