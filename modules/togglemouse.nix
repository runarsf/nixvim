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

  opts.mouse = "a";

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<Leader>mm" "<Plug>ToggleMouse" "Toggle mouse")
  ];
}
