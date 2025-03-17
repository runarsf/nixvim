{
  pkgs,
  inputs,
  system,
  lib,
  ...
}:
# TODO Rewrite to use custom lib instead of utils.
#  Waiting for better lib handling in nixvim https://github.com/nix-community/nixvim/pull/2328
rec {
  umport = inputs.nypkgs.lib.${system}.umport;

  # Merges a list of attributes into one, including lists and nested attributes.
  # Use this instead of lib.mkMerge if the merge type isn't allowed somewhere.
  # https://stackoverflow.com/a/54505212
  deepMerge = attrs: let
    merge = path:
      builtins.zipAttrsWith (n: values:
        if builtins.tail values == []
        then builtins.head values
        else if builtins.all builtins.isList values
        then lib.unique (inputs.nixpkgs.lib.concatLists values)
        else if builtins.all builtins.isAttrs values
        then merge (path ++ [n]) values
        else lib.last values);
  in
    merge [] attrs;

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

  luaToViml = str: ''
    lua << trim EOF
      ${str}
    EOF
  '';

  joinViml = str:
    lib.concatStringsSep " | "
    (lib.filter (line: line != "") (lib.splitString "\n" str));

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

  enable = xs: fill {enable = true;} xs;

  disable = xs: fill {enable = false;} xs;
}
