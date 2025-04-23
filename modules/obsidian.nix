{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule config "obsidian" {
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
}
