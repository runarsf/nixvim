{ pkgs, lib, helpers, ... }:

{
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
      plugin = (pkgs.vimUtils.buildVimPlugin rec {
        name = "search.nvim";
        src = pkgs.fetchFromGitHub {
            owner = "FabianWirth";
            repo = name;
            rev = "7b8f2315d031be73e14bc2d82386dfac15952614";
            hash = "sha256-88rMEtHTk5jEQ00YleSr8x32Q3m0VFZdxSE2vQ+f0rM=";
        };
      });
      config = lib.luaToViml ''
        require("search").setup({
          tabs = {
            {
              "Files",
              function(opts)
                opts = opts or {}
                if vim.fn.isdirectory(".git") == 1 then
                  builtin.git_files(opts)
                else
                  builtin.find_files(opts)
                end
              end
            }
          }
        })
      '';
    }

    sqlite-lua
    {
      plugin = (pkgs.vimUtils.buildVimPlugin rec {
        name = "smart-open.nvim";
        src = pkgs.fetchFromGitHub {
            owner = "danielfalk";
            repo = name;
            rev = "028bb71d20e8212da3514bf6dabfb17038d81ee4";
            hash = "sha256-mhOvWaRzPvGTFIMVAYg8Zd8YqpSs1xMMAaWTeh90Ee0=";
        };
      });
      config = lib.luaToViml ''
        require("telescope").load_extension("smart_open")
      '';
    }
  ];

  keymaps = [
    {
      key = "<C-p>";
      action = "<CMD>lua require'search'.open()<CR>";
      options.desc = "Live grep";
      mode = [ "i" "n" ];
    }
    # { # TODO Make this a pane in search
    #   key = "<C-p>";
    #   action = "<CMD>lua require'telescope'.extensions.smart_open.smart_open()<CR>";
    #   mode = [ "i" "n" ];
    # }
  ];
}
