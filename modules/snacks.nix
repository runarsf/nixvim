{
  config,
  lib,
  pkgs,
  helpers,
  ...
}: {
  options.modules.snacks.enable = lib.mkEnableOption "snacks";

  config = lib.mkIf config.modules.snacks.enable {
    plugins.snacks = {
      package = pkgs.master.vimPlugins.snacks-nvim;
      enable = true;
      autoLoad = true;
      lazyLoad.enable = false;
      settings = {
        bigfile.enabled = true;
        # TODO gremlins highlight indents https://github.com/vim-utils/vim-troll-stopper/blob/master/plugin/troll_stopper.vim#L14-L18
        # explorer = {
        #   enabled = true;
        #   replace_netrw = true;
        # };
        picker.sources.explorer.auto_close = true;
        image.enabled = true;
        indent = let
          char = "▏";
        in {
          enabled = true;
          indent.char = char;
          scope = {
            char = char;
          };
          chunk = {
            char = {
              vertical = char;
            };
          };
        };
        input.enabled = true;
        # notifier.enabled = true; # Not with notify + noice
        picker.enabled = true;
        profiler.enabled = true;
        quickfile.enabled = true;
        words.enabled = true;
        # TODO Replace toggleterm
        # terminal.enabled = true;
        # dashboard = {
        #   enabled = true;
        #   preset = {
        #     header = "HIII";
        #   };
        # };
      };
    };

    # keymaps = [
    #   {
    #     key = "<C-n>";
    #     action = "<CMD>lua Snacks.explorer.open()<CR>";
    #     options.desc = "Open file browser";
    #   }
    # ];

    # autoCmd = [
    #   {
    #     # Open files if vim started with no arguments
    #     event = ["VimEnter"];
    #     pattern = ["*"];
    #     callback = helpers.mkRaw ''
    #       function()
    #         if (vim.fn.expand("%") == "") then
    #           Snacks.explorer.open()
    #         end
    #       end
    #     '';
    #   }
    # ];
  };
}
