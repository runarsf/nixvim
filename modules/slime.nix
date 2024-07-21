{ config, lib, ... }:

{
  options.modules.slime.enable = lib.mkEnableOption "slime";

  config = lib.mkIf config.modules.slime.enable {
    plugins.vim-slime = {
      enable = true;
      settings = { target = "zellij"; };
    };
  };
}
