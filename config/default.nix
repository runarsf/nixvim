{ utils, ... }:

{
  imports = [ ./options.nix ./autocommands.nix ./plugins.nix ./keymaps.nix ]
    ++ utils.umport { path = ../modules; };

  # NOTE Packages added here are only available inside of neovim
  # extraPackages = with pkgs; [ sqlite ];

  enableMan = false;

  extraConfigLuaPre = builtins.readFile ./utils.lua;
}
