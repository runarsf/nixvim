{
  config,
  lib,
  helpers,
  ...
}:
lib.utils.mkLanguageModule config "dart" {
  plugins = {
    conform-nvim.settings.formatters_by_ft.dart.lsp_format = "prefer";

    flutter-tools = {
      enable = true;

      settings = {
        fvm = true;
        dev_log.enabled = false;
        debugger.enabled = true;
        closing_tags.enabled = true;
      };
    };
  };

  filetype = {
    extension.arb = "json";
    filename."pubspec.yaml" = "yaml.pubspec";
  };

  files = {
    "ftplugin/yaml_pubspec.vim" = {
      extraConfigVim =
        # vim
        ''
          if &filetype !=# 'yaml.pubspec'
            finish
          endif

          runtime! -buffer ftplugin/yaml.vim
        '';

      keymaps = with lib.utils.keymaps; [
        (mkBufferKeymap' "<localleader>g" "<CMD>FlutterPubGet<CR>" "Pub get")
        (mkBufferKeymap' "<localleader>u" "<CMD>FlutterPubUpgrade<CR>" "Pub upgrade")
      ];
    };

    "ftplugin/dart.lua" = {
      keymaps = with lib.utils.keymaps; [
        (mkBufferKeymap' "<leader>dc" (helpers.mkRaw ''
          function()
            if require('dap').session() ~= nil then
              require('dap').continue()
            else
              vim.cmd('FlutterRun')
            end
          end
        '') "Run / Continue")

        (mkBufferKeymap' "<leader>da" "<CMD>FlutterAttach<CR>" "Attach")
        (mkBufferKeymap' "<leader>dr" "<CMD>FlutterReload<CR>" "Hot-Reload")
        (mkBufferKeymap' "<leader>dR" "<CMD>FlutterRestart<CR>" "Hot-Restart")
        (mkBufferKeymap' "<leader>dQ" "<CMD>FlutterDetach<CR>" "Detach")

        # TODO: Add which key icons
        (mkBufferKeymap' "<localleader>e" "<CMD>FlutterEmulators<CR>" "Emulators")
        (mkBufferKeymap' "<localleader>d" "<CMD>FlutterDevices<CR>" "Devices")
        (mkBufferKeymap' "<localleader>o" "<CMD>FlutterOutlineToggle<CR>" "Outline")
        (mkBufferKeymap' "<localleader>i" "<CMD>FlutterDevTools<CR>" "DevTools")
        (mkBufferKeymap' "<localleader>l" "<CMD>FlutterLogToggle<CR>" "Toggle logs")
        (mkBufferKeymap' "<localleader>c" "<CMD>FlutterLogClear<CR>" "Clear logs")
        (mkBufferKeymap' "<localleader>g" "<CMD>FlutterPubGet<CR>" "Pub get")
        (mkBufferKeymap' "<localleader>u" "<CMD>FlutterPubUpgrade<CR>" "Pub upgrade")
        (mkBufferKeymap' "<localleader>v" "<CMD>FlutterVisualDebug<CR>" "Visual Debug")
      ];
    };
  };
}
/**
{
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<localleader>l", group = "Logs", icon = "" },
    },
    icons = {
      rules = {
        -- TODO: Group icon for logs
        { pattern = "flutter", icon = "󰃤", color = "red" },
        { pattern = "emulators", icon = "", color = "blue" },
        { pattern = "devices", icon = "", color = "blue" },
        { pattern = "outline", icon = "", color = "blue" },
        { pattern = "devtools", icon = "", color = "blue" },
        { pattern = "logs", icon = "", color = "blue" },
        { pattern = "pub get", icon = "", color = "blue" },
        { pattern = "pub upgrade", icon = "", color = "blue" },
        { pattern = "visual debug", icon = "", color = "blue" },
      },
    },
  },
},
*/

