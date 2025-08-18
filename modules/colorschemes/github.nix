{
  config,
  lib,
  ...
}:
lib.utils.mkColorschemeModule config "github" {
  # github_dark_default
  colorschemes.github-theme = {
    enable = true;
    settings = {
      transparent = lib.mkIf config.modules.colorschemes.transparent true;
    };
  };
}
