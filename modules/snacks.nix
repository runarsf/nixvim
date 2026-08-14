{
  config,
  lib,
  ...
}:
lib.mkModule config "snacks" {
  plugins = {
    snacks = {
      enable = true;
      autoLoad = true;
      lazyLoad.enable = false;
      settings = {
        bigfile.enabled = true;
        bufdelete.enabled = true;
        picker.sources.explorer.auto_close = true;
        quickfile.enabled = true;
      };
    };
  };
}
