{ config, lib, pkgs, utils, ... }:

{
  options.modules.outline.enable = lib.mkEnableOption "outline";

  config = lib.mkIf config.modules.outline.enable {
    extraPlugins = with pkgs.vimPlugins; [{
      plugin = aerial-nvim;
      config = utils.luaToViml ''
        require("aerial").setup();
        require("telescope").load_extension("aerial")
      '';
    }];

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
    }];
  };
}

