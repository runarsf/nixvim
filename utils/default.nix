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

  print = x: builtins.trace x x;

  mkModuleWithOptions = {
    config,
    name,
    moduleConfig,
    default ? false,
    extraOptions ? {},
    extraCondition ? true,
  }: let
    # TODO provide list instead
    namePathList = lib.splitString "." name;

    modulePath = ["modules"] ++ namePathList;
    enableOptionPath = modulePath ++ ["enable"];

    moduleOptions =
      {
        enable = lib.mkOption {
          inherit default;
          type = lib.types.bool;
          description = "Enable [${name}] module";
        };
      }
      // extraOptions;
  in {
    options = lib.setAttrByPath modulePath moduleOptions;

    config =
      lib.mkIf
      (lib.getAttrFromPath enableOptionPath config && extraCondition)
      moduleConfig;
  };

  mkLanguageModule = config: name: moduleConfig:
    mkModuleWithOptions {
      inherit config moduleConfig;
      name = "languages.${name}";
      default = config.modules.languages.all.enable;
    };

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
