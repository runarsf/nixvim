{
  config,
  lib,
  ...
}:
lib.mkModule config "todo" {
  # https://peps.python.org/pep-0350/#mnemonics
  plugins.todo-comments = {
    enable = true;
    settings = {
      highlight.pattern = ".*<(KEYWORDS)\\s*:*";
      # NOTE keyword = "bg" (not the default "wide") to avoid
      # https://github.com/folke/todo-comments.nvim/issues/400-ish:
      # "wide" computes end_col as finish+1, which errors when the
      # keyword is the last thing on the line (e.g. bare "TODO" with
      # nothing after it).
      highlight.keyword = "bg";
      search.pattern = "\\s\\b(KEYWORDS)\\b\\s";
      mergeKeywords = true;
      keywords = {
        # NOTE Sadly symbols don't work https://github.com/folke/todo-comments.nvim/issues/225
        "ALERT" = {
          icon = "󱗗 ";
          color = "error";
          # alt = [ "!!!" ];
        };
        "QUESTION" = {
          icon = " ";
          color = "info";
          alt = [
            "QUEST"
            "QSTN"
            "WTF"
            "FAQ"
          ]; # ???
        };
      };
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<Leader>T" "<CMD>TodoTelescope<CR>" "Show TODOs")
  ];
}
