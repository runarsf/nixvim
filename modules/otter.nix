{ config, lib, pkgs, utils, ... }:

{
  options.modules.otter.enable = lib.mkEnableOption "otter";

  config = lib.mkIf config.modules.otter.enable {
    plugins.otter.enable = true;
  };
}
