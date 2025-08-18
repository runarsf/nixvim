{
  config,
  lib,
  pkgs,
  ...
}:

# TODO https://github.com/kaplanelad/shellfirm

lib.utils.mkLanguageModule config "shell" {
  plugins = {
    lsp.servers = {
      bashls.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.bash = [
        "shellcheck"
        "shellharden"
        "shfmt"
      ];

      formatters = {
        shfmt.command = lib.getExe pkgs.shfmt;
        shellcheck.command = lib.getExe pkgs.shellcheck;
        shellharden.command = lib.getExe pkgs.shellharden;
      };
    };
  };
}
