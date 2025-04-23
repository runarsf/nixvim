{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule config "indents" {
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
}
