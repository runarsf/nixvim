{
  config,
  lib,
  ...
}:
{
  options.modules.ui.enable = lib.mkEnableOption "ui";

  config = lib.mkIf config.modules.ui.enable {
    plugins = {
      nui.enable = true;

      numbertoggle.enable = true;

      notify = {
        enable = true;
        settings = {
          # background_colour = "#000000";
          render = "compact";
          fps = 60;
          timeout = 3000;
          max_width = 80;
          icons = {
            trace = "";
            debug = "";
            info = "";
            warn = "";
            error = "";
          };
        };
      };

      noice = {
        enable = true;
        settings = {
          messages.view = "mini";
          notify.view = "notify";

          lsp.progress = {
            enable = true;
            view = "mini";
          };

          cmdline.format.find_and_replace = {
            title = " Find & replace ";
            icon = "󰛔";
            pattern = "^:%%s/";
            lang = "regex";
          };

          presets = {
            bottom_search.enable = true;
            command_palette.enable = true;
            long_message_to_split = true;
            inc_rename.enable = true;
            lsp_doc_border.enable = true;
          };

          views.notify.replace = true;
        };
      };
    };
  };
}
