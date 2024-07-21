{ config, lib, ... }:

{
  options.modules.notify.enable = lib.mkEnableOption "notify";

  config = lib.mkIf config.modules.notify.enable {
    plugins.notify = {
      enable = true;
      render = "minimal";
      stages = "slide";
      timeout = 4000;
      topDown = false;
      fps = 60;
    };
  };
}
