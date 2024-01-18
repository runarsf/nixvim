{ lib, pkgs, ... }: {
  imports = [
    ./options.nix
    ./autocommands.nix
    ./theme.nix
    ./plugins.nix
    ./keymaps.nix
  ];

  # TODO Formatting with nixfmt
  # TODO Properly package (python) dependencies

  extraPackages = with pkgs; [ glow ];

  extraConfigLuaPre =
    lib.concatStringsSep "\n" [ (builtins.readFile ./utils.lua) ];
}
