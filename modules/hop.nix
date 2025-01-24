{ config, lib, pkgs, utils, ... }:

{
  options.modules.hop.enable = lib.mkEnableOption "hop";

  config = lib.mkIf config.modules.hop.enable {
    extraPlugins = [{
      plugin = pkgs.vimPlugins.hop-nvim;
      config = utils.luaToViml ''
        require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
      '';
    }];
    keymaps = [
      {
        key = "f";
        action = "<CMD>HopPattern<CR>";
        options.desc = "Hop (pattern)";
      }
      {
        key = "F";
        action = "<CMD>HopAnywhere<CR>";
        options.desc = "Hop";
      }
    ];
  };
}

