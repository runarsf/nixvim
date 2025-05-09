{
  config,
  lib,
  ...
}:
lib.mkModule config "formatter" {
  plugins.conform-nvim = {
    enable = true;
    settings.formatters_by_ft."_" = ["trim_whitespace"];
  };

  keymaps = let
    runFormatter = "lua require('conform').format()";
  in [
    {
      key = "<Leader>f";
      action = "<CMD>${runFormatter}<CR>";
      options.desc = "Format current file";
    }
    {
      key = "<Leader>F";
      action = "<CMD>w | sleep 200m | ${runFormatter}<CR>";
      options.desc = "Format and save current file";
    }
  ];
}
