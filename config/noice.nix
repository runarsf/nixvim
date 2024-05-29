_:

{
  # FIXME mini mode doesn't work consistently, and sometimes switches off
  #  e.g. this will show an error from noice
  #       :echo "hi
  #       this will show a message from fidget
  #       :echo "hi"
  plugins.noice = {
    enable = true;
    notify.enabled = false;
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
