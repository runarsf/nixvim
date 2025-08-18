{lib, ...}: {
  options = {
    modules.colorschemes = {
      selected = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "ayu";
        description = "The colorscheme to use.";
      };

      transparent = lib.mkEnableOption "transparent colorscheme background";
    };
  };
}
