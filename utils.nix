{ inputs, system, lib, ... }:

{
  umport = inputs.nypkgs.lib.${system}.umport;

  # Merges a list of attributes into one, including lists and nested attributes.
  # Use this instead of lib.mkMerge if the merge type isn't allowed somewhere.
  # https://stackoverflow.com/a/54505212
  deepMerge = attrs:
    let
      merge = path:
        builtins.zipAttrsWith (n: values:
          if builtins.tail values == [ ] then
            builtins.head values
          else if builtins.all builtins.isList values then
            lib.unique (inputs.nixpkgs.lib.concatLists values)
          else if builtins.all builtins.isAttrs values then
            merge (path ++ [ n ]) values
          else
            lib.last values);
    in merge [ ] attrs;

  # TODO Use EOF for luaToViml instead
  # luaToViml = s:
  #   ''lua << EOF
  #     ${s}
  #   EOF
  #   '';
  luaToViml = s:
    let
      lines = lib.splitString "\n" s;
      nonEmptyLines = builtins.filter (line: line != "") lines;
      processed = map (line:
        if line == builtins.head nonEmptyLines then
          "lua " + line
        else
          "\\ " + line) nonEmptyLines;
    in lib.concatStringsSep "\n" processed;

  joinViml = s:
    lib.concatStringsSep " | "
    (lib.filter (line: line != "") (lib.splitString "\n" s));

  enable = attrs:
    builtins.listToAttrs (map (name: {
      name = name;
      value.enable = true;
    }) attrs);

  disable = attrs:
    builtins.listToAttrs (map (name: {
      name = name;
      value.enable = false;
    }) attrs);

  true = attrs:
    builtins.listToAttrs (map (name: {
      name = name;
      value = true;
    }) attrs);

  false = attrs:
    builtins.listToAttrs (map (name: {
      name = name;
      value = false;
    }) attrs);
}
