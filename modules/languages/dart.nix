{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
lib.utils.mkLanguageModule config "dart" {
  plugins = {
    lsp.servers = {
      dartls = {
        enable = true;
        settings = {
          lineLength = 120;
          showTodos = true;
          updateImportsOnRename = true;
          enableSnippets = true;
        };
      };
    };

    conform-nvim.settings = {
      formatters_by_ft.dart = [ "dart_format" ];

      # formatters = {
      #   alejandra = {
      #     command = lib.getExe pkgs.alejandra;
      #     args = ["--quiet" "-"];
      #   };
      #   nixfmt.command =
      #     lib.getExe
      #     inputs.nixfmt.packages.${pkgs.system}.default;
      # };
    };

    dap = {
      adapters = {
        executables = {
          dart = {
            command = "dart";
            args = [ "debug_adapter" ];
          };
          flutter = {
            command = "flutter";
            args = [ "debug_adapter" ];
          };
        };
      };

      configurations = {
        dart = [
          {
            name = "Dart";
            type = "dart";
            request = "launch";
            autoReload.enable = true;
            # program = "\${file}";
            # cwd = "\${workspaceFolder}";
          }

          {
            name = "Flutter";
            type = "flutter";
            request = "launch";
            autoReload.enable = true;
            # program = "\${file}";
            # cwd = "\${workspaceFolder}";
          }
        ];
      };
    };

    flutter-tools.enable = true;
  };
}
