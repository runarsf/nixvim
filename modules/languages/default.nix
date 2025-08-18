{lib, ...}: {
  # TODO: Refresh on a long cursorhold (e.g. pressing x to remove char doesn't update lsp status)
  options = {
    modules.languages.all.enable = lib.mkEnableOption "all configured languages";
  };
}
