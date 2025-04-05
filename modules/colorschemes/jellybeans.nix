{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.colorschemes.jellybeans.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.modules.colorschemes.all.enable;
    description = "jellybeans";
  };

  config = lib.mkIf config.modules.colorschemes.jellybeans.enable {
    colorscheme = lib.mkDefault "jellybeans";

    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = jellybeans-nvim;
        config = lib.utils.viml.fromLua ''
          require("jellybeans").setup()
        '';
      }
    ];
  };
}
