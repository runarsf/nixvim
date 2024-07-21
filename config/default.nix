{ pkgs, lib, ... }:

{
  imports = [
    ./options.nix
    ./autocommands.nix
    ./plugins.nix
    ./keymaps.nix
    ./colorscheme.nix
  ];

  enableMan = false;

  extraPackages = with pkgs; [ sqlite python311Packages.jupytext ];

  extraConfigLuaPre =
    lib.concatStringsSep "\n" [ (builtins.readFile ./utils.lua) ];
}
