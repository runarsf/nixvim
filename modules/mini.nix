{ config, lib, helpers, ... }:

{
  options.modules.mini.enable = lib.mkEnableOption "mini";

  config = lib.mkIf config.modules.mini.enable {
    plugins.mini = {
      enable = true;
      modules = {
        pairs = { };
        comment = { };
        align = { };
        surround = { };
        bufremove = { };
        move = { };
        trailspace = { };
        tabline = { };
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
      };
    };

    autoCmd = [
      {
        event = [ "User" ];
        pattern = [ "MiniFilesBufferCreate" ];
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

    keymaps = [{
      key = "<C-n>";
      action = "<CMD>lua MiniFiles.open()<CR>";
      options.desc = "Open file browser";
    }];
  };
}
