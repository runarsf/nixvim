{ config, ... }:

{
  extraConfigVim = ''
    function! CloseVimOrDeleteBuffer()
        " Check if there is only one tab open
        if tabpagenr('$') == 1
            " Check how many buffers are visible in the current tab
            let l:visible_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
            " Close Vim if this is the only visible buffer in the last tab
            if l:visible_buffers == 1
                quit
            else
                BufferClose
            endif
        else
            BufferClose
        endif
    endfunction
  '';

  # TODO If the cursor is at the last column, and on the second last column when pressing up/down, move to end
  extraConfigLua = ''
    function CursorMove(motion)
      local col = vim.api.nvim_win_get_cursor(0)[2]

      vim.api.nvim_command('normal! ' .. (vim.v.count == 0 and 1 or vim.v.count) .. 'g' .. motion)

      if motion == '$' then
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2] + 1

        if col == #line then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<End>', true, false, true), 'n', false)
        end
      elseif motion == '^' then
        local new_col = vim.api.nvim_win_get_cursor(0)[2]

        if col == new_col then
          if col == 0 then
            vim.api.nvim_command('normal! g^')
          else
            vim.api.nvim_command('normal! g0')
          end
        end
      end
    end
  '';

  globals = {
    mapleader = ",";
    maplocalleader = "<Space>";
  };
  keymaps = let
    mkMove = key: motion: {
      inherit key;
      action = "<CMD>lua CursorMove('${motion}')<CR>";
      mode = [ "n" "i" "v" ];
      options = {
        noremap = true;
        nowait = true;
        silent = true;
      };
    };
  in [
    (mkMove "<Up>" "k")
    (mkMove "<Down>" "j")
    (mkMove "<Home>" "^") # or 0
    (mkMove "<End>" "$")

    {
      key = "<leader><Space>";
      action = "<CMD>nohlsearch<CR>";
      options.desc = "Turn off highlighted matches";
    }
    {
      key = "<leader>..";
      action = if (config.plugins.notify.enable) then
        "<CMD>Telescope notify<CR>"
      else
        "<CMD>messages<CR>";
      options.desc = "Show messages";
    }
    {
      key = "<leader>.";
      action = if (config.plugins.notify.enable) then
        "<CMD>Notifications<CR>"
      else
        "<CMD>echo v:errmsg<CR>";
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
    {
      key = "<C-t>";
      action = "<CMD>tabnew<CR>";
      mode = "n";
      options.desc = "New tab";
    }
    {
      key = "<S-l>";
      action = "<CMD>BufferNext<CR>";
      mode = "n";
      options.desc = "Next buffer";
    }
    {
      key = "<S-h>";
      action = "<CMD>BufferPrevious<CR>";
      mode = "n";
      options.desc = "Previous buffer";
    }

    # Better indents
    {
      key = "<";
      action = "<gv";
      mode = "v";
      options.desc = "Decrease indent";
    }
    {
      key = ">";
      action = ">gv";
      mode = "v";
      options.desc = "Increase indent";
    }

    # Quickly edit macro
    {
      key = "<leader>em";
      action =
        "nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>";
      mode = "n";
      options.desc = "Edit macro";
    }

    # Quickly move current line
    # https://github.com/mhinz/vim-galore#quickly-move-current-line
    {
      key = "<A-j>";
      action = ":m .+1<CR>==";
      mode = "n";
      options.desc = "Move line down";
    }
    {
      key = "<A-k>";
      action = ":m .-2<CR>==";
      mode = "n";
      options.desc = "Move line up";
    }
    {
      key = "<A-j>";
      action = "<Esc>:m .+1<CR>==gi";
      mode = "i";
      options.desc = "Move line down";
    }
    {
      key = "<A-k>";
      action = "<Esc>:m .-2<CR>==gi";
      mode = "i";
      options.desc = "Move line up";
    }
    {
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      mode = "v";
      options.desc = "Move line down";
    }
    {
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      mode = "v";
      options.desc = "Move line up";
    }

    {
      key = "<leader>l";
      action = "<CMD>set cursorline!<CR>";
      options.desc = "Toggle cursorline";
    }
    {
      key = "<leader>L";
      action = "<CMD>set cursorcolumn!<CR>";
      options.desc = "Toggle cursorcolumn";
    }

    {
      key = "<leader>m";
      action = "<CMD>lua ToggleMouse()<CR>";
      options.desc = "Toggle mouse";
    }
    {
      key = "<leader>n";
      action = "<CMD>lua CopyMode()<CR>";
      options.desc = "Toggle copy-mode";
    }
    {
      key = "<leader>q";
      action = "<CMD>call CloseVimOrDeleteBuffer()<CR>";
      options.desc = "Quit";
    }
    {
      key = "<leader>Q";
      action = "<CMD>qa!<CR>";
      options.desc = "Quit all";
    }
    {
      key = "<leader>T";
      action = "<CMD>TodoTelescope<CR>";
      options.desc = "Show TODOs";
    }
    {
      key = "<leader>w";
      action = "<CMD>w!<CR>";
      options.desc = "Write";
    }
    {
      key = "<leader>wq";
      action = "<CMD>wq!<CR>";
      options.desc = "Write and quit";
    }
    {
      key = "<leader>wr";
      action = "<CMD>set wrap!<CR>";
      options.desc = "Toggle word wrap";
    }
    {
      key = "<leader>G";
      action = "<CMD>w<CR><CMD>lua Glow()<CR>";
      options.desc = "Preview markdown with glow";
    }
    {
      key = "<leader>u";
      action = "<CMD>UndotreeToggle<CR>";
      options.desc = "Toggle undo tree";
    }
    {
      key = "<leader>t";
      action = "<CMD>TroubleToggle<CR>";
      options.desc = "Toggle trouble";
    }
  ];
}
