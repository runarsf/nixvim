{
  config,
  pkgs,
  lib,
  ...
}: {
  options.modules.togglemouse.enable = lib.mkEnableOption "togglemouse";

  config = lib.mkIf config.modules.togglemouse.enable {
    extraPlugins = with pkgs.vimPlugins; [
      vim-togglemouse
    ];

    opts.mouse = "";

    keymaps = [
      {
        key = "<leader>m";
        action = "<Plug>ToggleMouse";
        options.desc = "Toggle mouse";
      }
    ];
  };
}
