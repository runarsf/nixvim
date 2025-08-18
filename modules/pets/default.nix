{
  config,
  lib,
  pkgs,
  helpers,
  ...
}:
# TODO: Automatically spawn random pet when user gets bored or doesn't interact with the editor for a while
lib.mkModule config "pets" {
  plugins = {
    lz-n.plugins = [
      {
        # TODO: Find a way to find these names conveniently, and to change them
        __unkeyed-1 = "vimplugin-duck.nvim";
        keys = [
          {__unkeyed-1 = "<Leader>Ps";}
          {__unkeyed-1 = "<Leader>Pk";}
        ];
      }
    ];

    which-key.settings.spec = let
      icon = {
        icon = "󰇥";
        color = "yellow";
      };
    in [
      {
        __unkeyed-1 = "<leader>P";
        group = "Pets";
        inherit icon;
      }
      {
        __unkeyed-1 = "<leader>Ps";
        inherit icon;
      }
      {
        __unkeyed-1 = "<leader>Pk";
        inherit icon;
      }
    ];
  };

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = duck;
      optional = true;
    }
  ];

  utils = lib.optionals config.modules.telescope.enable [
    ./pets.lua
  ];

  keymaps = lib.optionals config.modules.telescope.enable (with lib.utils.keymaps; [
    (mkKeymap' "<Leader>Ps" (helpers.mkRaw ''
      function()
        require('lz.n').trigger_load('telescope.nvim')
        require('utils.pets').PickPet()
      end
    '') "Spawn pet :⁾")
    (mkKeymap' "<Leader>Pk" (helpers.mkRaw ''
      function()
        require('duck').cook_all()
      end
    '') "Kill pets :⁽")
  ]);
}
