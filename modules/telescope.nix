{ config, lib, pkgs, helpers, utils, ... }:

{
  options.modules.telescope.enable = lib.mkEnableOption "telescope";

  config = lib.mkIf config.modules.telescope.enable {
    plugins.sqlite-lua.enable = true;

    plugins.telescope = {
      enable = true;
      settings.defaults.mappings.i."<esc>" =
        helpers.mkRaw "require('telescope.actions').close";
      extensions = {
        ui-select.enable = true;
        file-browser.enable = true;
        fzy-native = {
          enable = true;
          settings = {
            override_file_sorter = true;
            override_generic_sorter = true;
          };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = search;
        config = utils.luaToViml ''require("search").setup()'';
        #   config = utils.luaToViml ''
        #     require("search").setup({
        #       tabs = {
        #         {
        #           "Files",
        #           function(opts)
        #             opts = opts or {}
        #             if vim.fn.isdirectory(".git") == 1 then
        #               builtin.git_files(opts)
        #             else
        #               builtin.find_files(opts)
        #             end
        #           end
        #         }
        #       }
        #     })
        #   '';
      }
    ];

    keymaps = [
      {
        key = "<C-p>";
        action = "<CMD>lua require'search'.open()<CR>";
        options.desc = "Live grep";
        mode = [ "i" "n" ];
      }
      # {
      #   key = "<C-p><C-p>";
      #   action =
      #     "<CMD>lua require'telescope'.extensions.smart_open.smart_open()<CR>";
      #   mode = [ "i" "n" ];
      # }
    ];
  };
}

