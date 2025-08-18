{
  config,
  lib,
  helpers,
  ...
}:
lib.utils.mkColorschemeModule config "vscode" {
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
}
