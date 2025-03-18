{
  config,
  lib,
  ...
}: {
  options.modules.noice.enable = lib.mkEnableOption "noice";

  config = lib.mkIf config.modules.noice.enable {
    plugins = {
      nui.enable = true;
      notify.enable = true;
      noice = {
        enable = true;
        settings = {
          messages.view = "notify";
          notify.view = "notify";
          lsp.progress.enabled = false;
          presets = lib.utils.enable [
            "bottom_search"
            "command_palette"
            "long_message_to_split"
            "inc_rename"
            "lsp_doc_border"
          ];
        };
      };
    };
  };
}
