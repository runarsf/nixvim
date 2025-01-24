{ config, lib, ... }:

{
  options.modules.otter.enable = lib.mkEnableOption "otter";

  config = lib.mkIf config.modules.otter.enable {
    plugins.otter = {
      enable = true;
      settings.handle_leading_whitespace = true;
    };
  };
}
