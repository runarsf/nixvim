{
  config,
  lib,
  helpers,
  ...
}: {
  options.modules.colorschemes.vscode.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.modules.colorschemes.all.enable;
    description = "vscode";
  };

  config = lib.mkIf config.modules.colorschemes.vscode.enable {
    colorschemes.vscode = {
      enable = true;

      settings = {
        transparent = config.modules.colorschemes.transparent;
        underline_links = true;

        group_overrides = let
          color = name: helpers.mkRaw "require('vscode.colors').get_colors().${name}";
        in {
          "@string.special.path.nix" = {
            fg = color "vscOrange";
          };
        };
      };
    };

    plugins.notify.settings.background_colour = lib.mkIf config.modules.colorschemes.transparent "#181818";
  };
}
