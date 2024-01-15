{
  config = {
    luaLoader.enable = true;
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      list = true;
      listchars = "tab:┊»,trail:·,nbsp:⎵";
      timeoutlen = 300;
      mouse = "c";
      foldmethod = "marker";
      conceallevel = 0;
    };
    clipboard = {
      register = "unnamedplus";
      providers = {
        xsel.enable = true;
        wl-copy.enable = true;
      };
    };
    extraConfigVim = ''
      " Disable automatic commenting on newline
      set formatoptions-=c formatoptions-=r formatoptions-=o

      " Faster keyword completion
      set complete-=i   " disable scanning included files
      set complete-=t   " disable searching tags
    '';
  };
}
