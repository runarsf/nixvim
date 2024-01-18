{ pkgs, ... }:
# FIXME Incalid option to dictwatcherdel
let
  enabledPlugins = [
    # "image" # FIXME Broken package
    "nix"
    "nvim-autopairs"
    "telescope"
    "trouble"
    "lualine" # TODO Add mouse and copy indicators
    "presence-nvim"
    "nvim-colorizer"
    "flash"
    "which-key"
    "gitsigns"
    "wilder"
    "noice"
    "lastplace"
    "rainbow-delimiters"
    "typst-vim"
    "marks"
    "comment-nvim"
    # alpha
    "barbar"
    # chadtree
    # conform-nvim # TODO Formatters (nixfmt)
    # cursorline
    "diffview"
    "hmts"
    "instant"
    "intellitab"
    "multicursors"
    "undotree"
    # "mini" "edgy" # TODO Split mini in edgy
    # "fidget"
  ];
in {
  imports = [
    ./toggleterm.nix
    ./hop.nix
    ./rest-client.nix
    ./completions.nix
    ./lsp.nix
    ./folds.nix
  ];

  plugins = builtins.listToAttrs (map (name: {
    name = name;
    value = { enable = true; };
  }) enabledPlugins) // {
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
    molten = {
      enable = true;
      imageProvider = "image.nvim";
    };
    image = {
      enable = true;
      package = pkgs.stable.vimPlugins.image-nvim;
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    # APIs and Functions
    plenary-nvim
    popup-nvim

    vim-sleuth
    {
      plugin = tabout-nvim;
      config = ''
        lua require("tabout").setup({
        \   skip_ssl_verification = true,
        \ })
      '';
    }

    # Filetypes
    yuck-vim
    vim-just
  ];

  # Disable some builtin plugins
  globals = {
    loaded_tutor_mode_plugin = 1;
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
    loaded_netrwSettings = 1;
    loaded_netrwFileHandlers = 1;
  };
}
