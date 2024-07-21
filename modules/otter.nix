{ config, lib, pkgs, ... }:

{
  options.modules.otter.enable = lib.mkEnableOption "otter";

  config = lib.mkIf config.modules.otter.enable {
    extraPlugins = with pkgs.vimPlugins; [{
      plugin = otter-nvim;
      config = lib.luaToViml ''require("otter").setup()'';
    }];

    plugins.cmp.settings.sources = [{ name = "otter"; }];
  };
}
