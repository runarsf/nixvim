{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule config "outline" {
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = aerial-nvim;
      config = lib.utils.viml.fromLua ''
        require("aerial").setup();

        local ok, telescope = pcall(require, "telescope")
        if ok then
          telescope.load_extension("aerial")
        end
      '';
    }
    {
      plugin = namu-nvim;
      config = lib.utils.viml.fromLua ''
        require("namu").setup()
      '';
    }
  ];

  plugins.navbuddy = {
    enable = true;
    settings = {
      lsp.auto_attach = true;
      mappings = {
        "<Left>" = lib.nixvim.mkRaw "require('nvim-navbuddy.actions').parent()";
        "<Right>" = lib.nixvim.mkRaw "require('nvim-navbuddy.actions').children()";
        "-" = lib.nixvim.mkRaw "require('nvim-navbuddy.actions').hsplit()";
        "|" = lib.nixvim.mkRaw "require('nvim-navbuddy.actions').vsplit()";
      };
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<Leader>ss" (lib.nixvim.mkRaw ''
      function()
        require("namu.namu_symbols").show()
      end
    '') "Open Namu")
    (mkKeymap' "<Leader>sn" "<CMD>Navbuddy<CR>" "Open Navbuddy")
    (mkKeymap' "<Leader>sa" "<CMD>Telescope aerial<CR>" "Open Aerial")
  ];
}
