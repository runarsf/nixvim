_:

{
  keymaps = [
    {
      key = "<leader>db";
      action = "<CMD>lua require'dap'.toggle_breakpoint()<CR>";
      options.desc = "(debug) Add breakpoint";
    }
    {
      key = "<leader>ds";
      action = "<CMD>lua require'dap'.continue()<CR>";
      options.desc = "(debug) Start / Continue";
    }
    {
      key = "<leader>do";
      action = "<CMD>lua require'dap'.step_over()<CR>";
      options.desc = "(debug) Step over";
    }
    {
      key = "<leader>di";
      action = "<CMD>lua require'dap'.step_into()<CR>";
      options.desc = "(debug) Step into";
    }
    {
      key = "<leader>dO";
      action = "<CMD>lua require'dap'.step_out()<CR>";
      options.desc = "(debug) Step out";
    }
    {
      key = "<leader>dr";
      action = "<CMD>lua require'dap'.repl.toggle()<CR>";
      options.desc = "(debug) REPL";
    }
    {
      key = "<leader>dS";
      action = "<CMD>lua require'dap'.close()<CR>";
      options.desc = "(debug) Stop";
    }
  ];

  plugins = {
    rustaceanvim.enable = true;

    dap = {
      enable = true;
      signs.dapBreakpoint.text = "";
      extensions = {
        dap-ui.enable = true;
        dap-virtual-text.enable = true;
        dap-go.enable = true;
        dap-python = {
          enable = true;
          console = "integratedTerminal";
          # FIXME use resolvePython instead? or directly from pkgs
          adapterPythonPath = "~/.nix-profile/bin/python";
        };
      };

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

    cmp.settings.sources = [{ name = "dap"; }];
  };
}
