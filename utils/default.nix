args @ {
  inputs,
  system,
  lib,
  pkgs,
  ...
}: rec {
  viml = import ./viml.nix args;

  # TODO: Use concatPaths
  keymaps = import ./keymaps.nix args;

  setup' = name: setup name {};
  setup = name: options: let opts = lib.generators.toLua {} options; in viml.fromLua "require('${name}').setup(${opts})";

  mkLanguageModule = config: name: moduleConfig:
    lib.mkModuleWithOptions {
      inherit config moduleConfig;
      name = [
        "languages"
        name
      ];
      default = config.modules.languages.all.enable;
    };

  mkColorschemeModule = config: name: moduleConfig:
    lib.mkModuleWithOptions {
      inherit config moduleConfig;
      name = [
        "colorschemes"
        name
      ];
      default = config.modules.colorschemes.selected == name;
    };

  mkPlugins = config: plugins: let
    a = builtins.partition (plugin: lib.hasAttr plugin config.modules) (
      builtins.filter builtins.isString plugins
    );
    b = builtins.partition (plugin: lib.hasAttr plugin pkgs.vimPlugins) a.wrong;
    toAttrs = plugins:
      builtins.listToAttrs (
        map (plugin: {
          name = plugin;
          value.enable = true;
        })
        plugins
      );
  in {
    modules = toAttrs a.right;
    plugins = toAttrs b.wrong;
    extraPlugins =
      (builtins.filter (plugin: !builtins.isString plugin) plugins)
      ++ (map (plugin: builtins.getAttr plugin pkgs.vimPlugins) b.right);
  };
}
