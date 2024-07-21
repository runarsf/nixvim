{ config, lib, ... }:

{
  options.modules.sniprun.enable = lib.mkEnableOption "sniprun";

  config = lib.mkIf config.modules.sniprun.enable {
    keymaps = [
      {
        key = "<leader>r";
        action = "<CMD>SnipRun<CR>";
        mode = "n";
      }
      {
        key = "<leader>r";
        action = ":SnipRun<CR>";
        mode = "v";
      }
      {
        key = "<leader>R";
        action = "<CMD>%SnipRun<CR>";
      }
    ];

    plugins.sniprun.enable = true;
  };
}
