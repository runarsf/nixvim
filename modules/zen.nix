{
  config,
  lib,
  ...
}:
lib.mkModule config "zen" {
  plugins = {
    zen-mode.enable = true;
    twilight.enable = true;
    twilight.settings.context = 6;
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<Leader>z" "<CMD>ZenMode<CR>" "Zen mode")
  ];
}
