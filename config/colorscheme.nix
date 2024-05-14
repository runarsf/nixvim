{ pkgs, ... }:

let
  colorscheme = name: plugins: {
    colorscheme = name;
    extraPlugins = map (plugin:
      if builtins.isString plugin
      then builtins.getAttr plugin pkgs.vimPlugins
      else plugin
    ) (if builtins.isList plugins then plugins else [ plugins ]);
  };

in colorscheme "ayu" [ "neovim-ayu" "tokyonight-nvim"
  {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "github-nvim-theme";
      src = pkgs.fetchFromGitHub {
        owner = "projekt0n";
        repo = "github-nvim-theme";
        rev = "d832925e77cef27b16011a8dfd8835f49bdcd055";
        hash = "sha256-vsIr3UrnajxixDo0cp+6GoQfmO0KDkPX8jw1e0fPHo4=";
      };
    };
  }
  {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "monochrome.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "kdheepak";
        repo = "monochrome.nvim";
        rev = "2de78d9688ea4a177bcd9be554ab9192337d35ff";
        hash = "sha256-TgilR5jnos2YZeaJUuej35bQ9yE825MQk0s6gxwkAbA=";
      };
    };
  }
]
