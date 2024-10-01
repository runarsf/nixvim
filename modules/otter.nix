{ config, lib, pkgs, utils, ... }:

{
  options.modules.otter.enable = lib.mkEnableOption "otter";

  config = lib.mkIf config.modules.otter.enable {
    extraPlugins = with pkgs.vimPlugins; [{
      plugin = otter-nvim;
      config = utils.luaToViml ''require("otter").setup()'';
    }];

    plugins.cmp.settings.sources = [{ name = "otter"; }];
  };
}
