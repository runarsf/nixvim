{ config, lib, utils, ... }:

{
  options.modules.noice.enable = lib.mkEnableOption "noice";

  config = lib.mkIf config.modules.noice.enable {
    plugins.noice = {
      enable = true;
      messages.view = "mini";
      notify.view = "mini";
      lsp.progress.enabled = false;
      presets = utils.enable [
        "bottom_search"
        "command_palette"
        "long_message_to_split"
        "inc_rename"
        "lsp_doc_border"
      ];
    };
  };
}
