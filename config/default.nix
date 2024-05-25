{ pkgs, lib, ... }:

{
  imports = [
    ./options.nix
    ./autocommands.nix
    ./plugins.nix
    ./keymaps.nix
  ];

  enableMan = false;

  extraPackages = with pkgs; [ glow ];

  extraConfigLuaPre =
    lib.concatStringsSep "\n" [ (builtins.readFile ./utils.lua) ];
}
