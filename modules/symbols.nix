{ config, pkgs, lib, utils, ... }:

{
  options.modules.symbols.enable = lib.mkEnableOption "symbols";

  config = lib.mkIf config.modules.symbols.enable {
    keymaps = [{
      key = "<leader>s";
      action = "<CMD>lua require('symbol-usage').toggle()<CR>";
      options.desc = "Toggle Symbol Usage";
    }];

    extraPlugins = with pkgs; [{
      plugin = vimUtils.buildVimPlugin rec {
        name = "symbol-usage.nvim";
        src = fetchFromGitHub {
          owner = "Wansmer";
          repo = name;
          rev = "0f9b3da014b7e41559b643e7461fcabb2a7dc83a";
          hash = "sha256-vNVrh8MV7KZoh2MtP+hAr6Uz20qMMMUcbua/W71lRn0=";
        };
      };
      config = utils.luaToViml ''require("symbol-usage").setup()'';
    }];
  };
}
