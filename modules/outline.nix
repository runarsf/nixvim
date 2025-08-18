{
  config,
  lib,
  pkgs,
  helpers,
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
    lsp.autoAttach = true;
    mappings = {
      "<Left>" = "parent";
      "<Right>" = "children";
      "-" = "hsplit";
      "|" = "vsplit";
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<Leader>ss" (helpers.mkRaw ''
      function()
        require("namu.namu_symbols").show()
      end
    '') "Open Namu")
    (mkKeymap' "<Leader>sn" "<CMD>Navbuddy<CR>" "Open Navbuddy")
    (mkKeymap' "<Leader>sa" "<CMD>Telescope aerial<CR>" "Open Aerial")
  ];
}
