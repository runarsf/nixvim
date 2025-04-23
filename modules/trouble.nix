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

  keymaps = [
    {
      key = "<Leader>t";
      action = "<CMD>Trouble diagnostics<CR>";
      options.desc = "Toggle diagnostics";
    }
  ];
}
