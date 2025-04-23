{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkModule config "togglemouse" {
  extraPlugins = with pkgs.vimPlugins; [
    vim-togglemouse
  ];

  opts.mouse = "";

  keymaps = [
    {
      key = "<Leader>mm";
      action = "<Plug>ToggleMouse";
      options.desc = "Toggle mouse";
    }
  ];
}
