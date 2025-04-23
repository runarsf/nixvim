{
  config,
  lib,
  ...
}:
lib.mkModule config "which-key" {
  plugins = {
    which-key = {
      enable = true;
      settings = {
        preset = "helix";
        delay = 500;
        keys = {
          scroll_down = "<C-Down>";
          scroll_up = "<C-Up>";
        };
      };
    };
  };

  keymaps = [
    {
      key = "<LocalLeader>";
      action = ''<CMD>lua require('which-key').show()<CR>'';
      mode = ["n"];
      options.desc = "Show which-key";
    }
  ];
}
