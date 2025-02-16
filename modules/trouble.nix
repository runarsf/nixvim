{
  config,
  lib,
  ...
}: {
  options.modules.trouble.enable = lib.mkEnableOption "trouble";

  config = lib.mkIf config.modules.trouble.enable {
    plugins.trouble.enable = true;

    files."ftplugin/Trouble.lua" = {opts = {wrap = true;};};

    keymaps = [
      {
        key = "<leader>T";
        action = "<CMD>TodoTelescope<CR>";
        options.desc = "Show TODOs";
      }
      {
        key = "<leader>t";
        action = "<CMD>TroubleToggle<CR>";
        options.desc = "Toggle trouble";
      }
    ];
  };
}
