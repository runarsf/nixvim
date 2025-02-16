{
  config,
  lib,
  ...
}: {
  options.modules.indent-blankline.enable =
    lib.mkEnableOption "indent-blankline";

  config = lib.mkIf config.modules.indent-blankline.enable {
    plugins.indent-blankline = {
      enable = true;
      settings.indent.char = "▏";
    };
  };
}
