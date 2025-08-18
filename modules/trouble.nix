{
  config,
  lib,
  ...
}:
lib.mkModule config "trouble" {
  plugins.trouble.enable = true;

  files."ftplugin/Trouble.lua" = {
    opts = {
      wrap = true;
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<Leader>t" "<CMD>Trouble diagnostics<CR>" "Toggle diagnostics")
  ];
}
