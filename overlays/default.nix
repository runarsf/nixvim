{ inputs, lib, ... }:
let
  overlayFiles =
    with builtins;
    lib.pipe ./. [
      readDir
      (lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name))
      attrNames
    ];
in
{
  flake.overlays = lib.listToAttrs (
    map (filename: {
      name = lib.removeSuffix ".nix" filename;
      value = import (./. + "/${filename}") { flake = inputs.self; };
    }) overlayFiles
  );
}
