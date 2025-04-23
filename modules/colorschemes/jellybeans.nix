{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule' config ["colorschemes" "jellybeans"] config.modules.colorschemes.all.enable {
  colorscheme = lib.mkDefault "jellybeans";

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = jellybeans-nvim;
      config = lib.utils.viml.fromLua ''
        require("jellybeans").setup()
      '';
    }
  ];
}
