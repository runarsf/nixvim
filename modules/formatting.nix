{
  config,
  lib,
  helpers,
  ...
}:
lib.mkModule config "formatting" {
  plugins.conform-nvim = {
    enable = true;
    settings.formatters_by_ft."_" = ["trim_whitespace"];
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<Leader>f" (helpers.mkRaw ''
      function()
        require('conform').format()
      end
    '') "Format file")
  ];
}
