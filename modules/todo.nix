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
      highlight.pattern = ".*<(KEYWORDS)s*:*";
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
    (mkKeymap' "<Leader>T" "<CMD>Trouble todo<CR>" "Show TODOs")
  ];
}
