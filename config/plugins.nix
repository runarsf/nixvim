{ pkgs, ... }:
let
  enabledPlugins = [
    "nvim-autopairs"
    "telescope"
    "lualine"
    "presence-nvim"
    "nvim-colorizer"
    "flash"
    "wilder"
    "which-key"
    "gitsigns"
    "noice"
    "nix"
    "molten"
    "lastplace"
    "rainbow-delimiters"
    "typst-vim"
    "marks"
    "comment-nvim"
    "navbuddy"
    # "fidget"
    # "cursorline"
    # "diffview"
    # "multicursors"
    # "intellitab"
  ];
in {
  imports = [ ./rest-client.nix ./completions.nix ./lsp.nix ./folds.nix ];

  # Disable some builtin plugins
  globals = {
    loaded_tutor_mode_plugin = 1;
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
    loaded_netrwSettings = 1;
    loaded_netrwFileHandlers = 1;
  };

  # TODO Mini.files split with https://github.com/folke/edgy.nvim
  plugins = builtins.listToAttrs (map (name: {
    name = name;
    value = { enable = true; };
  }) enabledPlugins) // {
    toggleterm = {
      enable = true;
      direction = "float";
      openMapping = "<M-n>";
      floatOpts.border = "curved";
    };
    treesitter = {
      enable = true;
      indent = true;
    };
    oil = {
      enable = true;
      deleteToTrash = true;
    };
    notify = {
      enable = true;
      render = "minimal";
      timeout = 4000;
      topDown = false;
    };
    todo-comments = {
      enable = true;
      highlight.pattern = ".*<(KEYWORDS)s*:*";
      search.pattern = "\\s\\b(KEYWORDS)\\b\\s";

    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    # APIs and Functions
    plenary-nvim
    popup-nvim

    # Filetypes
    yuck-vim
    vim-just
  ];
}
