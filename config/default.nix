{ lib, pkgs, ... }: {
  imports = [ ./options.nix ./autocommands.nix ./theme.nix ./plugins.nix ./keymaps.nix ];

  extraPackages = [ pkgs.glow ];

  extraConfigLuaPre =
    lib.concatStringsSep "\n" [ (builtins.readFile ./utils.lua) ];
}
