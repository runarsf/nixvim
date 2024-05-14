{ pkgs, helpers, ... }:

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

  extraPlugins = [
    {
      plugin = (pkgs.vimUtils.buildVimPlugin {
        name = "search.nvim";
        src = pkgs.fetchFromGitHub {
            owner = "FabianWirth";
            repo = "search.nvim";
            rev = "cfde7b91c713d17e590aad2f0d22a68ddeba3043";
            hash = "sha256-nLDwEkpu+SmcJgnjhtqaXkeeX8YwPp3S2QYKNXaTJCI=";
        };
      });
      config = ''
        lua require("search").setup()
      '';
    }
  ];

  keymaps = [
    {
      key = "<C-p>";
      action = "<CMD>lua require'search'.open()<CR>";
      options.desc = "Live grep";
    }
  ];
}
