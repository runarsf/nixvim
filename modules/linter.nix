{
  lib,
  config,
  ...
}:
{
  options.modules.linter.enable = lib.mkEnableOption "linter";

  config = lib.mkIf config.modules.linter.enable {
    plugins.lint = {
      enable = true;

      # FIXME: https://github.com/mfussenegger/nvim-lint/issues/235
      autoCmd.event = [
        "BufReadPost"
        "BufWritePost"
        "InsertLeave"
      ];
    };
  };
}
