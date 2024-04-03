{ config, ... }:

{
  globals = {
    mapleader = ",";
    maplocalleader = "<Space>";
  };
  keymaps = [
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
    {
      key = "<C-p>";
      action = "<CMD>lua require'telescope.builtin'.live_grep()<CR>";
      options.desc = "Live grep";
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
      action = "<CMD>q<CR>";
      options.desc = "Quit";
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
