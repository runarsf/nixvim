{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.outline.enable = lib.mkEnableOption "outline";

  config = lib.mkIf config.modules.outline.enable {
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = aerial-nvim;
        config = lib.utils.viml.fromLua ''
          require("aerial").setup();
          require("telescope").load_extension("aerial")
        '';
      }
      {
        plugin = namu-nvim;
        config = lib.utils.viml.fromLua ''
          require("namu").setup()
        '';
      }
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

    keymaps = [
      {
        key = "<Leader>ss";
        options.desc = "Open Namu";
        mode = [ "n" ];
        action = ''<CMD>lua require("namu.namu_symbols").show()<CR>'';
        # options.silent = true;
        # action = '':try | execute 'lua require("namu.namu_symbols").show' | catch | try | execute 'Navbuddy' | catch | execute 'Telescope aerial' | endtry | endtry<CR>'';
      }
      {
        key = "<Leader>sn";
        options.desc = "Open Navbuddy";
        mode = [ "n" ];
        action = ''<CMD>Navbuddy<CR>'';
      }
      {
        key = "<Leader>sa";
        options.desc = "Open Aerial";
        mode = [ "n" ];
        action = ''<CMD>Telescope aerial<CR>'';
      }
    ];
  };
}
