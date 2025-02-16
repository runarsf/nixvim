{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.obsidian.enable = lib.mkEnableOption "obsidian";

  config = lib.mkIf config.modules.obsidian.enable {
    plugins = {
      clipboard-image = {
        enable = true;
        clipboardPackage = lib.mkDefault pkgs.wl-clipboard;
      };
      obsidian = {
        enable = true;
        settings = {
          picker.name = "telescope.nvim";
          workspaces = [
            {
              name = "Notes";
              path = "~/Documents/notes";
            }
          ];
        };
      };
    };
  };
}
