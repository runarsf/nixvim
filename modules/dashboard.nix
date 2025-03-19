{
  config,
  lib,
  helpers,
  pkgs,
  ...
}: {
  options.modules.dashboard.enable = lib.mkEnableOption "dashboard";

  config = lib.mkIf config.modules.dashboard.enable {
    extraPackages = with pkgs; [fortune-kind];

    plugins.alpha = {
      enable = true;
      opts = {
        margin = 5;
      };
      layout = helpers.mkRaw "alpha_layout()";
    };

    extraConfigLuaPre = lib.concatStringsSep "\n" [(builtins.readFile ./quotes.lua) (builtins.readFile ./alpha.lua)];
  };
}
