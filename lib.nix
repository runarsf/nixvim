{ inputs, system, ... }:

let
  lib = inputs.nixpkgs.lib;

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

in with inputs;
deepMerge [
  lib
  utils.lib
  nixvim.lib.${system}

  {
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
  }
]
