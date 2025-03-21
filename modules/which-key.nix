{
  config,
  lib,
  ...
}: {
  options.modules.which-key.enable = lib.mkEnableOption "which-key";

  config = lib.mkIf config.modules.which-key.enable {
    plugins = {
      which-key = {
        enable = true;
        settings = {
          preset = "helix";
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
        action = "<CMD>lua require('which-key').show()<CR>";
        mode = ["n" "v"];
        options.desc = "Show which-key";
      }
    ];
  };
}
