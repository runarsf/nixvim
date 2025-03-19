{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.buffers.enable = lib.mkEnableOption "buffers";

  config = lib.mkIf config.modules.buffers.enable {
    plugins = {
      bufferline = {
        enable = true;
      };
    };

    keymaps = [
      {
        key = "<C-t>";
        action = "<CMD>enew<CR>";
        mode = "n";
        options.desc = "Create a new buffer";
      }
      {
        key = "<S-l>";
        action = "<CMD>bnext<CR>";
        options.desc = "Next buffer";
      }
      {
        key = "<S-h>";
        action = "<CMD>bprevious<CR>";
        options.desc = "Previous buffer";
      }
      {
        key = "<leader>q";
        action = "<CMD>bp | bd #<CR>";
        options.desc = "Close buffer";
      }
      {
        key = "<leader>Q";
        action = "<CMD>qall<CR>";
        options.desc = "Quit";
      }
      {
        key = "<leader><Tab>";
        action = "<CMD>ls<CR>";
        options.desc = "List buffers";
      }
    ];
  };
}
