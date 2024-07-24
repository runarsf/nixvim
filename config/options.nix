{ pkgs, ... }:

{
  config = {
    luaLoader.enable = true;
    opts = {
      number = true;
      relativenumber = true;
      list = true;
      listchars = "tab:┊»,trail:·,nbsp:⎵,precedes:«,extends:»";
      timeoutlen = 300;
      ttimeoutlen = 50;
      mouse = "vc";
      conceallevel = 0;
      filetype = "on";
      confirm = true;
      backup = false;
      swapfile = false;
      pumblend = 0;
      splitbelow = true;
      splitright = true;
      ignorecase = true;
      smartcase = true;
      undofile = true;
      undolevels = 10000;
      updatetime = 300;
      scrolloff = 7;
      sidescrolloff = 5;
      wrap = false;
      linebreak = true;
      synmaxcol = 1000;
      cursorline = true;
      foldmethod = "marker";
      foldopen = "block,hor,insert,jump,mark,percent,quickfix,search,tag,undo";
      grepprg = "${pkgs.ripgrep}/bin/rg --vimgrep --hidden --glob '!.git'";

      # Also handled by sleuth
      shiftround = true;
      smartindent = true;
      shiftwidth = 2;
      autoindent = true;
      smarttab = true;
      tabstop = 2;
      expandtab = true;
    };
    clipboard = {
      register = "unnamedplus";
      providers = {
        xsel.enable = true;
        wl-copy.enable = true;
      };
    };
    extraConfigVim = ''
      " Faster keyword completion
      set complete-=i   " disable scanning included files
      set complete-=t   " disable searching tags

      " https://neovim.io/doc/user/faq.html#faq
      " set shortmess-=F
    '';
    # Disable some builtin plugins
    globals = {
      loaded_tutor_mode_plugin = 1;
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
      loaded_netrwSettings = 1;
      loaded_netrwFileHandlers = 1;
    };
  };
}
