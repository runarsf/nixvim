{ pkgs, ... }: {
  config = {
    luaLoader.enable = true;
    options = {
      number = true;
      relativenumber = true;
      list = true;
      listchars = "tab:┊»,trail:·,nbsp:⎵";
      timeoutlen = 300;
      ttimeoutlen = 50;
      mouse = "vc";
      foldmethod = "marker";
      conceallevel = 0;
      confirm = true;
      backup = false;
      swapfile = false;
      pumblend = 10;
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
      foldopen = "block,hor,insert,jump,mark,percent,quickfix,search,tag,undo";

      shiftround = true;
      smartindent = true;
      grepprg = "${pkgs.ripgrep}/bin/rg --vimgrep --hidden --glob '!.git'";
      shiftwidth = 2;
      autoindent = true;
      smarttab = true;
      tabstop = 2;
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
    '';
  };
}
