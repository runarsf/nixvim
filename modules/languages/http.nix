{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.mkLanguageModule config "http" {
  plugins = {
    kulala = {
      enable = true;
      settings = {
        display_mode = "float";
        vscode_rest_client_environmentvars = true;
        global_keymaps = true;
      };
    };

    # lsp.servers = {
    #   kulala_ls = {
    #     enable = true;
    #     # TODO: Waiting for kulala-ls to be in upstream https://github.com/NixOS/nixpkgs/issues/347263
    #     package =
    #       import
    #       "${
    #         builtins.fetchTarball {
    #           url = "https://github.com/nixos/nixpkgs/archive/be349a99e84b5e3d836d890f71533bcc3abe4fd0.tar.gz";
    #           sha256 = "sha256:0hzwfv36j1hv8273bmirvm91bnz4pr2fk4yi6xfq9ybn481mqb74";
    #         }
    #       }/pkgs/by-name/ku/kulala-ls/package.nix"
    #       {
    #         inherit
    #           (pkgs)
    #           lib
    #           nix-update-script
    #           fetchFromGitHub
    #           buildNpmPackage
    #           ;
    #       };
    #   };
    # };

    conform-nvim.settings = {
      formatters_by_ft.http = ["kulala-fmt"];

      formatters.kulala-fmt.command = lib.getExe pkgs.kulala-fmt;
    };
  };

  extraPackages = with pkgs; [
    grpcurl
    jq
    libxml2
  ];

  filetype.extension.http = "http";
}
