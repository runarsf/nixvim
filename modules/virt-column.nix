{
  config,
  lib,
  ...
}: {
  options.modules.virt-column.enable = lib.mkEnableOption "virt-column";

  config = lib.mkIf config.modules.virt-column.enable {
    plugins.virt-column = {
      enable = true;
      settings = {
        char = "▕";
        virtcolumn = "80,100,120";
      };
    };
  };
}
