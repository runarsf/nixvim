{ pkgs, ... }:

let
  active = "ayu";

  colorscheme = name: plugins: {
    colorscheme = name;
    extraPlugins = map (plugin:
      if builtins.isString plugin then
        builtins.getAttr plugin pkgs.vimPlugins
      else
        plugin) (if builtins.isList plugins then plugins else [ plugins ]);
  };

in with pkgs;
colorscheme active [
  "neovim-ayu"
  "tokyonight-nvim"
  "catppuccin-nvim"
  "kanagawa-nvim"
  # "vscode-nvim" # TODO Replace vim-code-dark when this is closed https://github.com/Mofiqul/vscode.nvim/issues/136
  {
    plugin = vimPlugins.vim-code-dark;
    config = "let g:codedark_modern=1";
  }
  {
    plugin = vimUtils.buildVimPlugin rec {
      name = "yugen.nvim";
      src = fetchFromGitHub {
        owner = "bettervim";
        repo = name;
        rev = "ce74413d31ca14f59aecb04b1eb60b33f431db8c";
        hash = "sha256-Y6LLu1cvT2SyJ9BeFu4C0WnbRmp2Evb7VrTOkmLqQeg=";
      };
    };
  }
  {
    plugin = vimUtils.buildVimPlugin rec {
      name = "Mountain";
      src = "${fetchFromGitHub {
        owner = "mountain-theme";
        repo = name;
        rev = "48b5732a2368a0ff75081108a88c126ded5ab73d";
        hash = "sha256-2I21DAbmVueyhRXJUcokiB5iXt2YzlvAV/YLR+CCL3Y=";
      }}/vim";
    };
  }
  {
    plugin = vimUtils.buildVimPlugin rec {
      name = "github-nvim-theme";
      src = fetchFromGitHub {
        owner = "projekt0n";
        repo = name;
        rev = "d832925e77cef27b16011a8dfd8835f49bdcd055";
        hash = "sha256-vsIr3UrnajxixDo0cp+6GoQfmO0KDkPX8jw1e0fPHo4=";
      };
    };
  }
  {
    plugin = vimUtils.buildVimPlugin rec {
      name = "monochrome.nvim";
      src = fetchFromGitHub {
        owner = "kdheepak";
        repo = name;
        rev = "2de78d9688ea4a177bcd9be554ab9192337d35ff";
        hash = "sha256-TgilR5jnos2YZeaJUuej35bQ9yE825MQk0s6gxwkAbA=";
      };
    };
  }
]
