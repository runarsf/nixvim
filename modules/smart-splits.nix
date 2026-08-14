{
  config,
  lib,
  ...
}:
lib.mkModule config "smart-splits" {
  performance.combinePlugins.standalonePlugins = ["smart-splits.nvim"];

  plugins.smart-splits = {
    enable = true;
    settings.resize_mode.resize_keys = [
      "<Left>"
      "<Down>"
      "<Up>"
      "<Right>"
    ];
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap ["n" "i" "x"] "<A-S-Left>" (lib.nixvim.mkRaw ''
      function()
        require('smart-splits').resize_left()
      end
    '') "Resize left")
    (mkKeymap ["n" "i" "x"] "<A-S-Down>" (lib.nixvim.mkRaw ''
      function()
        require('smart-splits').resize_down()
      end
    '') "Resize down")
    (mkKeymap ["n" "i" "x"] "<A-S-Up>" (lib.nixvim.mkRaw ''
      function()
        require('smart-splits').resize_up()
      end
    '') "Resize up")
    (mkKeymap ["n" "i" "x"] "<A-S-Right>" (lib.nixvim.mkRaw ''
      function()
        require('smart-splits').resize_right()
      end
    '') "Resize right")

    (mkKeymap ["n" "i" "x"] "<S-Left>" (lib.nixvim.mkRaw ''
      function()
        require('smart-splits').move_cursor_left()
      end
    '') "Move left")
    (mkKeymap ["n" "i" "x"] "<S-Down>" (lib.nixvim.mkRaw ''
      function()
        require('smart-splits').move_cursor_down()
      end
    '') "Move down")
    (mkKeymap ["n" "i" "x"] "<S-Up>" (lib.nixvim.mkRaw ''
      function()
        require('smart-splits').move_cursor_up()
      end
    '') "Move up")
    (mkKeymap ["n" "i" "x"] "<S-Right>" (lib.nixvim.mkRaw ''
      function()
        require('smart-splits').move_cursor_right()
      end
    '') "Move right")

    (mkKeymap ["n" "i" "x"] "<S-Tab>" (lib.nixvim.mkRaw ''
      function()
        require('smart-splits').move_cursor_previous()
      end
    '') "Move previous")
  ];
}
