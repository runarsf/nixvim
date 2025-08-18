{
  lib,
  pkgs,
  ...
}: {
  enableMan = false;

  luaLoader.enable = true;

  /*
     performance = {
    # Way too tedious to maintain
    # combinePlugins.enable = true;

    byteCompileLua = {
      enable = true;
      luaLib = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
  */

  clipboard = {
    register = "unnamedplus";
    providers = {
      xsel.enable = true;
      wl-copy.enable = true;
    };
  };

  extraPackages = with pkgs; [sqlite];

  filetype = {
    extension = {
      vert = "glsl";
      frag = "glsl";
      comp = "glsl";
      glsl = "glsl";
      geom = "glsl";
      jet = "cpp.jet";
      j2 = "cpp.j2";
    };
  };

  opts = rec {
    # Also handled by sleuth
    shiftwidth = 2;
    tabstop = builtins.floor (shiftwidth * 1.5);
    softtabstop = 0;
    shiftround = true;
    smartindent = true;
    autoindent = true;
    smarttab = true;
    expandtab = true;

    number = true;
    relativenumber = true;
    list = true;
    listchars = {
      tab = "┊»";
      trail = "·";
      nbsp = "⎵";
      precedes = "«";
      extends = "»";
    };
    fillchars = {
      foldopen = "";
      foldclose = "";
      fold = " ";
      foldsep = " ";
      diff = "╱";
      eob = " ";
      lastline = " ";
    };
    showbreak = "↪" + lib.strings.replicate (shiftwidth - 1) " ";
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
  };

  # Disable some builtin plugins
  globals = lib.fill 1 [
    "loaded_gzip"
    "loaded_netrw"
    "loaded_matchit"
    "loaded_tarPlugin"
    "loaded_zipPlugin"
    "loaded_matchparen"
    "loaded_netrwPlugin"
    "loaded_2html_plugin"
    "loaded_netrwSettings"
    "loaded_tutor_mode_plugin"
    "loaded_netrwFileHandlers"
  ];

  extraConfigVim = ''
    " Faster keyword completion
    set complete-=i   " disable scanning included files
    set complete-=t   " disable searching tags

    " https://neovim.io/doc/user/faq.html#faq
    " set shortmess-=F
  '';
}
