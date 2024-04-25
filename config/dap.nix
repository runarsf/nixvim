_:

{
  keymaps = [
    {
      key = "<leader>db";
      action = "<CMD>lua require'dap'.toggle_breakpoint()<CR>";
      options.desc = "(debug) Add breakpoint";
    }
    {
      key = "<leader>dc";
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
      key = "<leader>ds";
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
          # FIXME use resolvePython instead?
          adapterPythonPath = "~/.nix-profile/bin/python";
        };
      };

      # adapters.executables = {
      #   gdb = {
      #     command = "gdb";
      #     args = [ "-i" "dap" ];
      #   };

      #   lldb = {
      #     command = "lldb-dap";
      #     name = "lldb";
      #   };

      #   dart = {
      #     command = "dart";
      #     args = [ "debug_adapter" ];
      #   };

      #   flutter = {
      #     command = "flutter";
      #     args = [ "debug_adapter" ];
      #   };
      # };
    };

    cmp.settings.sources = [
      { name = "dap"; }
    ];
  };
}
