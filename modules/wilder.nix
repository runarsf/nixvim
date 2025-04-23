{
  config,
  lib,
  ...
}:
lib.mkModule config "wilder" {
  plugins.wilder = {
    enable = true;
    modes = [
      "?"
      ":"
      "/"
    ];
    renderer = ''
      wilder.popupmenu_renderer({
        pumblend = 20,
        highlighter = wilder.basic_highlighter(),
        highlights = {
          border = 'Normal',
        },
        border = 'rounded',
        reverse = 1,
        left = {' ', wilder.popupmenu_devicons()},
        right = {' ', wilder.popupmenu_scrollbar()},
      })
    '';
  };
}
