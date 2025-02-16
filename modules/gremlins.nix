{
  config,
  lib,
  pkgs,
  ...
}:
# https://vim.fandom.com/wiki/Highlight_unwanted_spaces
{
  options.modules.gremlins.enable = lib.mkEnableOption "gremlins";

  config = lib.mkIf config.modules.gremlins.enable {
    extraPlugins = with pkgs.vimPlugins; [
      vim-unicode-homoglyphs
      vim-troll-stopper
    ];
  };
}
