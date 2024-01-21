{
  plugins.noice = {
    # Seems to be affected by this issue https://github.com/neovim/neovim/issues/21857
    enable = true;
    presets = { bottom_search = true; command_palette = true; long_message_to_split = true; inc_rename = true; lsp_doc_border = false; };
  };
}
