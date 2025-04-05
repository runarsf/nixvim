{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.gremlins.enable = lib.mkEnableOption "gremlins";

  # snacks_dashboard, terminal
  config = lib.mkIf config.modules.gremlins.enable {
    # https://vim.fandom.com/wiki/Highlight_unwanted_spaces
    extraPlugins = with pkgs.vimPlugins; [
      # vim-unicode-homoglyphs
      vim-troll-stopper
    ];
  };
}
