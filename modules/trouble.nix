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
        key = "<leader>t";
        action = "<CMD>TroubleToggle<CR>";
        options.desc = "Toggle trouble";
      }
    ];
  };
}
