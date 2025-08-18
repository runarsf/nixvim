{
  config,
  lib,
  helpers,
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

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<LocalLeader>" (helpers.mkRaw ''
      function()
        require('which-key').show()
      end
    '') "Show which-key")
  ];
}
