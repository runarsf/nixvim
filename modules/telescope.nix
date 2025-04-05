{
  config,
  lib,
  pkgs,
  helpers,
  ...
}:
{
  # TODO exclude .stack-work and .git and node_modules (ALSO in alpha.nvim)
  options.modules.telescope = {
    enable = lib.mkEnableOption "telescope";
    teleOpts = lib.mkOption {
      type = lib.types.str;
      default = ''{ no_ignore = true, no_ignore_parent = true, hidden = true, use_regex = true, file_ignore_patterns = { '^\.git/', '^\.stack-work/' } }'';
    };
  };

  config = lib.mkIf config.modules.telescope.enable {
    plugins.sqlite-lua.enable = true;

    extraConfigLuaPre = ''
      telescope_options = ${config.modules.telescope.teleOpts}
    '';

    plugins.telescope = {
      enable = true;
      settings.defaults.mappings.i."<esc>" = helpers.mkRaw "require('telescope.actions').close";
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
        config = lib.utils.viml.fromLua ''
          local builtin = require('telescope.builtin')
          require('search').setup({
            initial_tab = 1,
            tabs = {
              { name = "Files", tele_func = builtin.find_files },
              { name = "Grep", tele_func = builtin.live_grep },
            }
          })
        '';
      }
    ];

    extraPackages = with pkgs; [ ripgrep ];

    keymaps = [
      {
        key = "<C-p>";
        action = ''<CMD>lua require('search').open({ tab_name = 'Files', tele_opts = telescope_options })<CR>'';
        options.desc = "Search files";
        mode = "n";
      }
      {
        key = "<leader>p";
        action = ''<CMD>lua require('search').open({ tab_name = 'Grep', tele_opts = telescope_options })<CR>'';
        options.desc = "Grep files";
        mode = "n";
      }
    ];
    # TODO https://github.com/danielfalk/smart-open.nvim
    # {
    #   key = "<C-p><C-p>";
    #   action =
    #     "<CMD>lua require'telescope'.extensions.smart_open.smart_open()<CR>";
    #   mode = [ "i" "n" ];
    # }
  };
}
