{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  lang = "nix";
  cfg = config.modules.languages.${lang};
in {
  options.modules.languages.${lang}.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.modules.languages.all.enable;
    description = "${lang} language support";
  };

  config = lib.mkIf cfg.enable {
    plugins = {
      lsp.servers = {
        # TODO Use nixd
        # nixd = {
        #   enable = true;
        #   package = inputs.nixd.packages.${pkgs.system}.default;
        # };
        nil_ls = {
          enable = true;
          package = inputs.nil_ls.packages.${pkgs.system}.default;
        };
      };

      conform-nvim.settings = {
        formatters_by_ft.nix = {
          # TODO Remove nixfmt when alejandra supports pipe operator: https://github.com/kamadorueda/alejandra/issues/436
          __unkeyed-1 = "alejandra";
          __unkeyed-2 = "nixfmt";
          stop_after_first = true;
        };

        formatters = {
          alejandra = {
            command = lib.getExe pkgs.alejandra;
            args = ["--quiet" "-"];
          };
          nixfmt.command =
            lib.getExe
            inputs.nixfmt.packages.${pkgs.system}.default;
        };
      };

      hmts.enable = true;
    };
  };
}
