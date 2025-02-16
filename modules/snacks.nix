{
  config,
  lib,
  ...
}: {
  options.modules.snacks.enable = lib.mkEnableOption "snacks";

  config = lib.mkIf config.modules.snacks.enable {
    plugins.snacks = {
      enable = true;
      settings = {
        bigfile.enabled = true;
        notifier.enabled = true;
        quickfile.enabled = true;
      };
    };
  };
}
