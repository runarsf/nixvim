{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.snacks.enable = lib.mkEnableOption "snacks";

  config = lib.mkIf config.modules.snacks.enable {
    plugins = {
      # lazy.enable = true;

      snacks = {
        enable = true;
        package = pkgs.master.vimPlugins.snacks-nvim;
        autoLoad = true;
        lazyLoad.enable = false;
        settings = {
          bigfile.enabled = true;
          # TODO gremlins highlights indents https://github.com/vim-utils/vim-troll-stopper/blob/master/plugin/troll_stopper.vim#L14-L18
          # explorer = {
          #   enabled = true;
          #   replace_netrw = true;
          # };
          bufdelete.enabled = true;
          picker.sources.explorer.auto_close = true;
          image.enabled = true;
          indent = let
            char = "▏";
          in {
            enabled = true;
            animate.enabled = false;
            indent.char = char;
            scope.char = char;
          };
          input.enabled = true;
          picker.enabled = true;
          profiler.enabled = true;
          quickfile.enabled = true;
          words.enabled = true;
          # dashboard = {
          # enabled = true;
          # };
          # TODO Replace toggleterm
          # terminal.enabled = true;
        };
      };
    };
  };
}
