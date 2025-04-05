{
  config,
  lib,
  helpers,
  ...
}:
{
  options.modules.smart-splits.enable = lib.mkEnableOption "smart-splits";

  config = lib.mkIf config.modules.smart-splits.enable {
    plugins.smart-splits = {
      enable = true;
      settings.resize_mode.resize_keys = [
        "<Left>"
        "<Down>"
        "<Up>"
        "<Right>"
      ];
    };

    extraConfigLuaPre = ''
      SmartSplits = require('smart-splits')
    '';

    keymaps = [
      {
        key = "<A-S-Left>";
        action = helpers.mkRaw "SmartSplits.resize_left";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Resize left";
      }
      {
        key = "<A-S-Down>";
        action = helpers.mkRaw "SmartSplits.resize_down";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Resize down";
      }
      {
        key = "<A-S-Up>";
        action = helpers.mkRaw "SmartSplits.resize_up";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Resize up";
      }
      {
        key = "<A-S-Right>";
        action = helpers.mkRaw "SmartSplits.resize_right";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Resize right";
      }

      {
        key = "<S-Left>";
        action = helpers.mkRaw "SmartSplits.move_cursor_left";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Move left";
      }
      {
        key = "<S-Down>";
        action = helpers.mkRaw "SmartSplits.move_cursor_down";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Move down";
      }
      {
        key = "<S-Up>";
        action = helpers.mkRaw "SmartSplits.move_cursor_up";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Move up";
      }
      {
        key = "<S-Right>";
        action = helpers.mkRaw "SmartSplits.move_cursor_right";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Move right";
      }
      {
        key = "<S-Tab>";
        action = helpers.mkRaw "SmartSplits.move_cursor_previous";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Move previous";
      }

      {
        key = "<leader><leader><Left>";
        action = helpers.mkRaw "SmartSplits.swap_buf_left";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Swap buffer left";
      }
      {
        key = "<leader><leader><Down>";
        action = helpers.mkRaw "SmartSplits.swap_buf_down";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Swap buffer down";
      }
      {
        key = "<leader><leader><Up>";
        action = helpers.mkRaw "SmartSplits.swap_buf_up";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Swap buffer up";
      }
      {
        key = "<leader><leader><Right>";
        action = helpers.mkRaw "SmartSplits.swap_buf_right";
        mode = [
          "n"
          "i"
          "x"
        ];
        options.desc = "Swap buffer right";
      }
    ];
  };
}
