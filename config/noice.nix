_:

{
  # FIXME mini mode doesn't work consistently, and sometimes switches off
  plugins.noice = {
    enable = true;
    notify.enabled = false;
    messages.enabled = false;
    notify.view = "mini";
    messages.view = "mini";
    presets = {
      bottom_search = true;
      command_palette = false;
      long_message_to_split = true;
      inc_rename = true;
      lsp_doc_border = true;
    };
  };
}
