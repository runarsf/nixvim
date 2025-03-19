{
  lib,
  pkgs,
  ...
}: {
  enableMan = false;
  luaLoader.enable = true;
  clipboard = {
    register = "unnamedplus";
    providers = {
      xsel.enable = true;
      wl-copy.enable = true;
    };
  };

  extraPackages = with pkgs; [sqlite];

  opts = rec {
    number = true;
    relativenumber = true;
    list = true;
    listchars = "tab:┊»,trail:·,nbsp:⎵,precedes:«,extends:»";
    showbreak = "↪";
    timeoutlen = 350;
    filetype = "on";
    confirm = true;
    backup = false;
    swapfile = false;
    splitright = true;
    splitbelow = true;
    ignorecase = true;
    smartcase = true;
    undofile = true;
    undolevels = 10000;
    updatetime = 1000;
    synmaxcol = 1000;
    scrolloff = 7;
    sidescrolloff = 5;
    cursorline = true;
    foldopen = "block,hor,insert,jump,mark,percent,quickfix,search,tag,undo";
    grepprg = "${lib.getExe pkgs.ripgrep} --vimgrep --hidden --glob '!.git'";

    wrap = false;
    linebreak = true;
    breakindent = true;

    # Also handled by sleuth
    shiftwidth = 2;
    tabstop = builtins.floor (shiftwidth * 1.5);
    softtabstop = 0;
    shiftround = true;
    smartindent = true;
    autoindent = true;
    smarttab = true;
    expandtab = true;
  };

  # Disable some builtin plugins
  globals = {
    loaded_tutor_mode_plugin = 1;
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
    loaded_netrwSettings = 1;
    loaded_netrwFileHandlers = 1;
  };

  extraConfigLuaPre = builtins.readFile ./utils.lua;

  extraConfigVim = ''
    " Faster keyword completion
    set complete-=i   " disable scanning included files
    set complete-=t   " disable searching tags

    " https://neovim.io/doc/user/faq.html#faq
    " set shortmess-=F
  '';
}
