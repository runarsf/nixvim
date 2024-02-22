{ lib, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./autocommands.nix
    ./plugins.nix
    ./keymaps.nix
  ];

  extraPackages = with pkgs; [ glow ];

  extraConfigLuaPre =
    lib.concatStringsSep "\n" [ (builtins.readFile ./utils.lua) ];
}
