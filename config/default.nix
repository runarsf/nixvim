{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [ ./options.nix ./autocommands.nix ./theme.nix ./plugins.nix ./keymaps.nix ];

  extraConfigLua = builtins.readFile ./utils.lua;
}

# TODO When entering parenthesis, add the matching one automatically
# TODO Fix slow input
