{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "iac" {
  plugins = {
    lsp.servers = {
      terraformls.enable = true;
    };

    conform-nvim.settings = {
      formatters_by_ft = {
        terraform = [
          "terraform_fmt"
        ];
        tofu = [
          "tofu_fmt"
        ];
      };

      formatters = {
        terraform_fmt = {
          command = lib.getExe pkgs.terraform;
          args = ["fmt" "-" "-write=false"];
        };
        tofu_fmt = {
          command = lib.getExe pkgs.opentofu;
          args = ["fmt" "-" "-write=false"];
        };
      };
    };
  };
}
