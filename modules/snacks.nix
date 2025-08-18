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
        # TODO https://github.com/folke/snacks.nvim/blob/main/docs/scratch.md
        bigfile.enabled = true;
        bufdelete.enabled = true;
        picker.sources.explorer.auto_close = true;
        quickfile.enabled = true;
      };
    };
  };
}
