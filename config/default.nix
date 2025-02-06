{ utils, ... }:

{
  imports = [ ./options.nix ./autocommands.nix ./plugins.nix ./keymaps.nix ]
    ++ utils.umport { path = ../modules; };

  # extraPackages = with pkgs; [ sqlite ];

  enableMan = false;

  extraConfigLuaPre = builtins.readFile ./utils.lua;
}
