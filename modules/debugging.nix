{
  config,
  lib,
  helpers,
  ...
}:
lib.mkModule config "debugging" {
  plugins = {
    dap = {
      enable = true;
      signs.dapBreakpoint.text = "";
    };
    dap-ui.enable = true;
    dap-virtual-text.enable = true;

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>d";
        group = "Debugging";
        icon = {
          icon = "󰃤";
          color = "red";
        };
      }
    ];
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>dB" (helpers.mkRaw ''
      function()
        require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end
    '') "Breakpoint Condition")
    (mkKeymap' "<leader>db" (helpers.mkRaw ''
      function()
        require("dap").toggle_breakpoint()
      end
    '') "Toggle Breakpoint")
    (mkKeymap' "<leader>dc" (helpers.mkRaw ''
      function()
        require("dap").continue()
      end
    '') "Run/Continue")
    (mkKeymap' "<leader>da" (helpers.mkRaw ''
      function()
        require("dap").continue({ before = get_args })
      end
    '') "Run with Args")
    (mkKeymap' "<leader>dC" (helpers.mkRaw ''
      function()
        require("dap").run_to_cursor()
      end
    '') "Run to Cursor")
    (mkKeymap' "<leader>dg" (helpers.mkRaw ''
      function()
        require("dap").goto_()
      end
    '') "Go to Line (No Execute)")
    (mkKeymap' "<leader>di" (helpers.mkRaw ''
      function()
        require("dap").step_into()
      end
    '') "Step Into")
    (mkKeymap' "<leader>dj" (helpers.mkRaw ''
      function()
        require("dap").down()
      end
    '') "Down")
    (mkKeymap' "<leader>dk" (helpers.mkRaw ''
      function()
        require("dap").up()
      end
    '') "Up")
    (mkKeymap' "<leader>dl" (helpers.mkRaw ''
      function()
        require("dap").run_last()
      end
    '') "Run Last")
    (mkKeymap' "<leader>do" (helpers.mkRaw ''
      function()
        require("dap").step_out()
      end
    '') "Step Out")
    (mkKeymap' "<leader>dO" (helpers.mkRaw ''
      function()
        require("dap").step_over()
      end
    '') "Step Over")
    (mkKeymap' "<leader>dP" (helpers.mkRaw ''
      function()
        require("dap").pause()
      end
    '') "Pause")
    (mkKeymap' "<leader>dr" (helpers.mkRaw ''
      function()
        require("dap").repl.toggle()
      end
    '') "Toggle REPL")
    (mkKeymap' "<leader>ds" (helpers.mkRaw ''
      function()
        require("dap").session()
      end
    '') "Session")
    (mkKeymap' "<leader>dt" (helpers.mkRaw ''
      function()
        require("dap").terminate()
      end
    '') "Terminate")
    (mkKeymap' "<leader>dw" (helpers.mkRaw ''
      function()
        require("dap.ui.widgets").hover()
      end
    '') "Widgets")
    (mkKeymap' "<leader>du" (helpers.mkRaw ''
      function()
        require("dapui").toggle({ })
      end
    '') "Dap UI")
    (mkKeymap ["n" "v"] "<leader>de" (helpers.mkRaw ''
      function()
        require("dapui").eval()
      end
    '') "Eval")
  ];
}
