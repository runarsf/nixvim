{
  config,
  lib,
  ...
}: {
  options.modules.zen.enable = lib.mkEnableOption "zen";

  config = lib.mkIf config.modules.zen.enable {
    plugins = {
      zen-mode.enable = true;
      twilight.enable = true;
      twilight.settings.context = 6;
    };

    keymaps = [
      {
        key = "<leader>z";
        action = "<CMD>ZenMode<CR>";
        mode = "n";
      }
    ];
  };
}
