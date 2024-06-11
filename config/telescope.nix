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
            rev = "cfde7b91c713d17e590aad2f0d22a68ddeba3043";
            hash = "sha256-nLDwEkpu+SmcJgnjhtqaXkeeX8YwPp3S2QYKNXaTJCI=";
        };
      });
      config = lib.luaToViml ''
        require("search").setup()
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
      key = "<C-p><C-p>";
      action = "<CMD>lua require'search'.open()<CR>";
      options.desc = "Live grep";
      mode = [ "i" "n" ];
    }
    {
      key = "<C-p>";
      action = "<CMD>lua require'telescope'.extensions.smart_open.smart_open()<CR>";
      mode = [ "i" "n" ];
    }
  ];
}
