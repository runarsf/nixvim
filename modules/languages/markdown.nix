{
  config,
  lib,
  ...
}:
lib.utils.mkLanguageModule config "markdown" {
  performance.combinePlugins.standalonePlugins = ["markview" "helpview"];

  plugins = {
    lsp.servers = {
      marksman.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.json = ["deno_fmt"];
    };

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

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<Leader>md" "<CMD>Glow<CR>" "Preview markdown")
  ];

  files."ftplugin/markdown.lua" = {
    opts = {
      conceallevel = 2;
      wrap = true;
      breakindent = true;
      linebreak = true;
    };
  };
}
