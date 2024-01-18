{ lib, pkgs, ... }: {
  imports = [
    ./options.nix
    ./autocommands.nix
    ./theme.nix
    ./plugins.nix
    ./keymaps.nix
  ];

  extraPackages = with pkgs; [ glow imagemagick ];
  extraLuaPackages = with pkgs; [ magick ];
  extraPython3Packages = p:
    with p; [
      pynvim
      jupyter-client
      cairosvg # for image rendering
      pnglatex # for image rendering
      plotly # for image rendering
      pyperclip
    ];

  extraConfigLuaPre =
    lib.concatStringsSep "\n" [ (builtins.readFile ./utils.lua) ];
}
