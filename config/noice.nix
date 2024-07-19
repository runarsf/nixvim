_:

{
  plugins.noice = {
    enable = true;
    messages.view = "mini";
    notify.view = "mini";
    lsp.progress.enabled = false;
    presets = {
      bottom_search = true;
      command_palette = true;
      long_message_to_split = true;
      inc_rename = true;
      lsp_doc_border = true;
    };
  };
}
