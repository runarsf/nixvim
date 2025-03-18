{
  config,
  lib,
  ...
}: let
  lang = "markdown";
  cfg = config.modules.languages.${lang};
in {
  options.modules.languages.${lang}.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.modules.languages.all.enable;
    description = "${lang} language support";
  };

  config = lib.mkIf cfg.enable {
    plugins = {
      glow = {
        enable = true;
        settings = {
          border = "rounded";
          height = 1000;
          width = 1000;
          height_ratio = 1.0;
          width_ratio = 1.0;
        };
      };
      markview.enable = true;
      helpview.enable = true;
    };

    keymaps = [
      {
        key = "<leader>md";
        action = "<CMD>Glow<CR>";
        options.desc = "Preview markdown";
      }
    ];

    files."ftplugin/markdown.lua" = {
      opts = {
        conceallevel = 2;
        wrap = true;
        breakindent = true;
        linebreak = true;
      };
    };
  };
}
