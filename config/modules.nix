{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    luaModules = with lib.types;
      lib.mkOption {
        type = listOf (either path (attrsOf str));
        default = [];
        description = "List of lua files/directories or attribute sets with inline lua code, each added to the lua/ directory under its own name";
      };
  };

  config = {
    extraFiles = let
      attrUtils = builtins.filter builtins.isAttrs config.luaModules;
      pathUtils = builtins.filter builtins.isPath config.luaModules;

      isDir = util:
        (builtins.readDir (dirOf util))."${baseNameOf (toString util)}" or null
        == "directory";

      attrFiles =
        builtins.concatLists
        (map (
            util:
              map (name: {
                name = "lua/${name}.lua";
                value = {text = builtins.getAttr name util;};
              })
              (builtins.attrNames util)
          )
          attrUtils);

      pathFiles =
        builtins.concatMap (
          util:
            if isDir util
            then
              map (luaFile: {
                name = "lua/${lib.removePrefix "${toString util}/" (toString luaFile)}";
                value = {source = luaFile;};
              })
              (lib.filesystem.concatPaths {
                paths = [util];
                suffix = ".lua";
                filterDefault = false;
              })
            else [
              {
                name = "lua/${baseNameOf (toString util)}";
                value = {source = util;};
              }
            ]
        )
        pathUtils;

      # Shared, generic lua helpers (not tied to any one module) live under
      # ../utils and keep the require("utils.<name>") prefix, since they're
      # genuinely common code rather than one module's implementation detail.
      sharedUtilFiles =
        map (util: {
          name = "lua/utils/${baseNameOf (toString util)}";
          value = {source = util;};
        })
        (lib.filesystem.concatPaths {
          paths = [../utils];
          suffix = ".lua";
          filterDefault = false;
        });
    in
      builtins.listToAttrs (attrFiles ++ pathFiles ++ sharedUtilFiles);

    modules =
      lib.enable [
        "lsp"
        "completions"
        "formatting"
        "linting"
        "debugging"
        "treesitter"
        "otter"
        "telescope"
        "copilot"
        "pets"
        "gremlins"
        "mini"
        "snacks"
        "todo"
        "buffers"
        "outline"
        "hop"
        "togglemouse"
        "terminal"
        "trouble"
        "colors"
        "folds"
        "lualine"
        "ui"
        "zen"
        "dashboard"
        "which-key"
        "smart-splits"
        "editing"
      ]
      // {
        colorschemes = {
          selected = "ayu";
          transparent = true;
        };
        languages = {
          all.enable = true;
          http.enable = false;
        };
      };

    plugins = lib.enable [
      "lastplace"
      "sleuth"
      "neocord"
      "gitsigns"
      "intellitab"
      "git-conflict"
      "fugitive"
      # "barbecue"
      # "marks"
      # "improved-search"
      # "diffview"
      # "barbar"
      # "better-escape"
    ];

    extraPlugins = with pkgs.vimPlugins; [
      openingh-nvim
      nvim-nio
    ];

    extraLuaPackages = rocks:
      with rocks; [
        nvim-nio
      ];
  };
}
