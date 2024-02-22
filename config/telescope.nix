_:

{
  plugins.telescope = {
    enable = true;
    extensions = {
      frecency.enable = true;
      ui-select.enable = true;
      file_browser.enable = true;
      fzy-native = {
        enable = true;
        overrideFileSorter = true;
        overrideGenericSorter = true;
      };
    };
  };
}
