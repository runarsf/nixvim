{
  config,
  lib,
  ...
}:
lib.utils.mkLanguageModule config "markdown" {
  plugins = {
    glow = {
      enable = true;
      settings = {
        border = "rounded";
        height = 1000;
        width = 1000;
        height_ratio = 1.0;
        width_ratio = 1.0;
      };
    };
    markview.enable = true;
    helpview.enable = true;
  };

  keymaps = [
    {
      key = "<leader>md";
      action = "<CMD>Glow<CR>";
      options.desc = "Preview markdown";
    }
  ];

  files."ftplugin/markdown.lua" = {
    opts = {
      conceallevel = 2;
      wrap = true;
      breakindent = true;
      linebreak = true;
    };
  };
}
