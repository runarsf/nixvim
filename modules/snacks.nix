{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.snacks.enable = lib.mkEnableOption "snacks";

  config = lib.mkIf config.modules.snacks.enable {
    plugins = {
      snacks = {
        enable = true;
        package = pkgs.master.vimPlugins.snacks-nvim;
        autoLoad = true;
        lazyLoad.enable = false;
        settings = {
          # TODO https://github.com/folke/snacks.nvim/blob/main/docs/scratch.md
          bigfile.enabled = true;
          bufdelete.enabled = true;
          picker.sources.explorer.auto_close = true;
          image.enabled = true;
          # indent = let
          #   char = "▏";
          # in {
          #   enabled = true;
          #   animate.enabled = false;
          #   indent.char = char;
          #   scope.char = char;
          # };
          input.enabled = true;
          picker.enabled = true;
          quickfile.enabled = true;
          words.enabled = true;
        };
      };
    };
  };
}
