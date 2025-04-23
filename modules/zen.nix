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

  keymaps = [
    {
      key = "<Leader>z";
      action = "<CMD>ZenMode<CR>";
      mode = "n";
    }
  ];
}
