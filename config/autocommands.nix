{
  helpers,
  config,
  lib,
  ...
}: let
  autoCmds = [
    {
      # Show cursor-line
      group = "cursorline";
      event = [
        "InsertLeave"
        "WinEnter"
      ];
      pattern = ["*"];
      command = "silent! set cursorline";
    }
    {
      # Hide cursor-line
      group = "cursorline";
      event = [
        "InsertEnter"
        "WinLeave"
      ];
      pattern = ["*"];
      command = "silent! set nocursorline";
    }
    {
      # Check if file has been modified on disk
      group = "checktime";
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      pattern = ["*"];
      callback = helpers.mkRaw ''
        function()
          if vim.o.buftype ~= "nofile" then
            vim.cmd.checktime()
          end
        end
      '';
    }
    {
      # Get rid of the pesky cmd window
      group = "forbid_cmdwin";
      event = ["CmdwinEnter"];
      pattern = ["*"];
      callback = helpers.mkRaw ''
        function()
          vim.cmd.q()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":", true, false, true), 'n', false)
        end
      '';
    }
    {
      # Forbid replace mode
      group = "forbid_replace";
      event = [
        "InsertEnter"
        "InsertChange"
      ];
      pattern = ["*"];
      callback = helpers.mkRaw ''
        function()
          if vim.v.insertmode == "r" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Insert>", true, false, true), "n", false)
          end
        end
      '';
    }
    {
      group = "yank_highlight";
      event = ["TextYankPost"];
      pattern = ["*"];
      callback = helpers.mkRaw ''
        function()
          (vim.hl or vim.highlight).on_yank({
            higroup = "CurSearch",
            timeout = 200,
          })
        end
      '';
    }
    {
      group = "resize_splits";
      event = ["VimResized"];
      pattern = ["*"];
      callback = helpers.mkRaw ''
        function()
          local current_tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. current_tab)
        end
      '';
    }
    {
      group = "close_with_q";
      event = ["FileType"];
      pattern = [
        "PlenaryTestPopup"
        "checkhealth"
        "dbout"
        "gitsigns-blame"
        "grug-far"
        "help"
        "lspinfo"
        "neotest-output"
        "neotest-output-panel"
        "neotest-summary"
        "notify"
        "qf"
        "spectre_panel"
        "startuptime"
        "tsplayground"
      ];
      callback = helpers.mkRaw ''
        function(event)
          vim.bo[event.buf].buflisted = false
          vim.schedule(function()
            vim.keymap.set("n", "q", function()
              vim.cmd("close")
              pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
              buffer = event.buf,
              silent = true,
              desc = "Quit buffer",
            })
          end)
        end
      '';
    }
    {
      group = "mkdir_p";
      event = ["BufWritePre"];
      pattern = ["*"];
      callback = helpers.mkRaw ''
        function(event)
          if event.match:match("^%w%w+:[\\/][\\/]") then
            return
          end
          local file = vim.uv.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end
      '';
    }
    # { # Disable automatic commenting on newline
    #   event = [ "FileType" "BufNewFile" "BufRead" ];
    #   pattern = [ "*" ];
    #   command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o";
    # }
  ];

  # Dynamically generate autoGroups from the groups used in autoCmds
  usedGroups = lib.unique (map (cmd: cmd.group) autoCmds);
in {
  autoGroups = lib.genAttrs usedGroups (name: {clear = true;});
  autoCmd = autoCmds;
}
