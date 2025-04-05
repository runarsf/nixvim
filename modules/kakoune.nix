{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.kak.enable = lib.mkEnableOption "kak.nvim";

  config = lib.mkIf config.modules.kak.enable {
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = kak-nvim;
        config = lib.utils.viml.fromLua ''
          require("kak").setup({
            full = true,
            which_key_integration = true,

            experimental = {
              rebind_visual_aiAI = true,
            }
          })
        '';
      }
    ];
  };
}
