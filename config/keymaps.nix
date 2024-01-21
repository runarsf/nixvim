{ config, ... }: {
  globals = {
    mapleader = ",";
    maplocalleader = "<Space>";
  };
  keymaps = [
    {
      key = "<leader><Space>";
      action = "<CMD>nohlsearch<CR>";
    }
    {
      key = "<leader>..";
      action = if (config.plugins.notify.enable) then
        "<CMD>Telescope notify<CR>"
      else
        "<CMD>messages<CR>";
    }
    { # Show last error
      key = "<leader>.";
      action = if (config.plugins.notify.enable) then
        "<CMD>Notifications<CR>"
      else
        "<CMD>echo v:errmsg<CR>";
    }
    {
      key = "<C-p>";
      action = "<CMD>lua require'telescope.builtin'.live_grep()<CR>";
    }

    # Better window navigation
    {
      key = "<C-Left>";
      action = "<CMD>wincmd h<CR>";
      mode = "n";
    }
    {
      key = "<C-Down>";
      action = "<CMD>wincmd j<CR>";
      mode = "n";
    }
    {
      key = "<C-Up>";
      action = "<CMD>wincmd k<CR>";
      mode = "n";
    }
    {
      key = "<C-Right>";
      action = "<CMD>wincmd l<CR>";
      mode = "n";
    }

    # Better tab movement
    {
      key = "<C-t>";
      action = "<CMD>tabnew<CR>";
      mode = "n";
    }
    {
      key = "<S-l>";
      action = "<CMD>BufferNext<CR>";
      mode = "n";
    }
    {
      key = "<S-h>";
      action = "<CMD>BufferPrevious<CR>";
      mode = "n";
    }

    # Better indents
    {
      key = "<";
      action = "<gv";
      mode = "v";
    }
    {
      key = ">";
      action = ">gv";
      mode = "v";
    }

    # Quickly edit macro
    {
      key = "<leader>m";
      action =
        "nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>";
      mode = "n";
    }

    # Quickly move current line
    # https://github.com/mhinz/vim-galore#quickly-move-current-line
    {
      key = "<A-j>";
      action = ":m .+1<CR>==";
      mode = "n";
    }
    {
      key = "<A-k>";
      action = ":m .-2<CR>==";
      mode = "n";
    }
    {
      key = "<A-j>";
      action = "<Esc>:m .+1<CR>==gi";
      mode = "i";
    }
    {
      key = "<A-k>";
      action = "<Esc>:m .-2<CR>==gi";
      mode = "i";
    }
    {
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      mode = "v";
    }
    {
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      mode = "v";
    }

    {
      key = "<leader>l";
      action = "<CMD>set cursorline!<CR>";
    }
    {
      key = "<leader>L";
      action = "<CMD>set cursorcolumn!<CR>";
    }

    {
      key = "<leader>m";
      action = "<CMD>lua ToggleMouse()<CR>";
    }
    {
      key = "<leader>n";
      action = "<CMD>lua CopyMode()<CR>";
    }
    {
      key = "<leader>q";
      action = "<CMD>q<CR>";
    }
    {
      key = "<leader>T";
      action = "<CMD>TodoTelescope<CR>";
    }
    {
      key = "<leader>w";
      action = "<CMD>w!<CR>";
    }
    {
      key = "<leader>wq";
      action = "<CMD>wq!<CR>";
    }
    {
      key = "<leader>wr";
      action = "<CMD>set wrap!<CR>";
    }
    {
      key = "<leader>M";
      action = "<CMD>w<CR><CMD>lua Glow()<CR>";
    }
    {
      key = "<leader>u";
      action = "<CMD>UndotreeToggle<CR>";
    }
    {
      key = "<C-n>";
      action = "<CMD>lua MiniFiles.open()<CR>";
    }
    {
      key = "<leader>t";
      action = "<CMD>TroubleToggle<CR>";
    }
  ];
}
