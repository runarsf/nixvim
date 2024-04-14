{ lib, pkgs, ... }:

{
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
  files."ftplugin/markdown.lua" = {
    opts.conceallevel = 2;
  };
}
