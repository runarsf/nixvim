{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.indents.enable = lib.mkEnableOption "indents";

  config = lib.mkIf config.modules.indents.enable {
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = indentmini;
        config = lib.utils.viml.fromLua ''
          require("indentmini").setup({
            char = "▏",
          })
        '';
      }
    ];
  };
}
