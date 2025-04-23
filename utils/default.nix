args @ {
  inputs,
  system,
  lib,
  pkgs,
  ...
}: {
  viml = import ./viml.nix args;

  mkLanguageModule = config: name: moduleConfig:
    lib.mkModuleWithOptions {
      inherit config moduleConfig;
      name = [
        "languages"
        name
      ];
      default = config.modules.languages.all.enable;
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
