args @ {
  inputs,
  system,
  lib,
  pkgs,
  ...
}: rec {
  inherit (inputs.nypkgs.lib.${system}) umport;

  viml = import ./viml.nix args;

  enable = fill {enable = true;};

  disable = fill {enable = false;};

  # FIXME Doesn't work for nested values ([ "formatter" ["formatter" "nix"] ])
  fill = value: xs:
    lib.foldl' (acc: x:
      acc
      // lib.setAttrByPath (
        if builtins.isList x
        then x
        else [x]
      )
      value) {}
    xs;

  mkPlugins = config: plugins: let
    a =
      builtins.partition (plugin: lib.hasAttr plugin config.modules)
      (builtins.filter builtins.isString plugins);
    b =
      builtins.partition (plugin: lib.hasAttr plugin pkgs.vimPlugins) a.wrong;
    toAttrs = plugins:
      builtins.listToAttrs (map (plugin: {
          name = plugin;
          value.enable = true;
        })
        plugins);
  in {
    modules = toAttrs a.right;
    plugins = toAttrs b.wrong;
    extraPlugins =
      (builtins.filter (plugin: !builtins.isString plugin) plugins)
      ++ (map (plugin: builtins.getAttr plugin pkgs.vimPlugins) b.right);
  };
}
