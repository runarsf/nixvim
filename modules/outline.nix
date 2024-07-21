{ config, lib, pkgs, ... }:

{
  options.modules.outline.enable = lib.mkEnableOption "outline";

  config = lib.mkIf config.modules.outline.enable {
    extraPlugins = with pkgs.vimPlugins; [{
      plugin = aerial-nvim;
      config = lib.luaToViml ''
        require("aerial").setup();
        require("telescope").load_extension("aerial")
      '';
    }
    # {
    #   plugin = outline-nvim;
    #   config = lib.luaToViml ''require("outline").setup()'';
    # }
      ];

    plugins.navbuddy = {
      enable = true;
      lsp.autoAttach = true;
      mappings = {
        "<Left>" = "parent";
        "<Right>" = "children";
        "-" = "hsplit";
        "|" = "vsplit";
      };
    };

    keymaps = [{
      key = "<C-l>";
      options.silent = true;
      action =
        ":try | execute 'Navbuddy' | catch | execute 'Telescope aerial' | endtry<CR>";
    }
    # {
    #   key = "<leader>o";
    #   action = "<CMD>AerialToggle<CR>";
    #   options.desc = "Toggle outline";
    # }
    # {
    #   key = "<leader>o";
    #   action = "<CMD>Outline<CR>";
    #   options.desc = "Toggle outline";
    # }
      ];
  };
}
