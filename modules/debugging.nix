{
  config,
  lib,
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
    (mkKeymap' "<leader>dB" (lib.nixvim.mkRaw ''
      function()
        require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end
    '') "Breakpoint Condition")
    (mkKeymap' "<leader>db" (lib.nixvim.mkRaw ''
      function()
        require("dap").toggle_breakpoint()
      end
    '') "Toggle Breakpoint")
    (mkKeymap' "<leader>dc" (lib.nixvim.mkRaw ''
      function()
        require("dap").continue()
      end
    '') "Run/Continue")
    (mkKeymap' "<leader>da" (lib.nixvim.mkRaw ''
      function()
        require("dap").continue({ before = get_args })
      end
    '') "Run with Args")
    (mkKeymap' "<leader>dC" (lib.nixvim.mkRaw ''
      function()
        require("dap").run_to_cursor()
      end
    '') "Run to Cursor")
    (mkKeymap' "<leader>dg" (lib.nixvim.mkRaw ''
      function()
        require("dap").goto_()
      end
    '') "Go to Line (No Execute)")
    (mkKeymap' "<leader>di" (lib.nixvim.mkRaw ''
      function()
        require("dap").step_into()
      end
    '') "Step Into")
    (mkKeymap' "<leader>dj" (lib.nixvim.mkRaw ''
      function()
        require("dap").down()
      end
    '') "Down")
    (mkKeymap' "<leader>dk" (lib.nixvim.mkRaw ''
      function()
        require("dap").up()
      end
    '') "Up")
    (mkKeymap' "<leader>dl" (lib.nixvim.mkRaw ''
      function()
        require("dap").run_last()
      end
    '') "Run Last")
    (mkKeymap' "<leader>do" (lib.nixvim.mkRaw ''
      function()
        require("dap").step_out()
      end
    '') "Step Out")
    (mkKeymap' "<leader>dO" (lib.nixvim.mkRaw ''
      function()
        require("dap").step_over()
      end
    '') "Step Over")
    (mkKeymap' "<leader>dP" (lib.nixvim.mkRaw ''
      function()
        require("dap").pause()
      end
    '') "Pause")
    (mkKeymap' "<leader>dr" (lib.nixvim.mkRaw ''
      function()
        require("dap").repl.toggle()
      end
    '') "Toggle REPL")
    (mkKeymap' "<leader>ds" (lib.nixvim.mkRaw ''
      function()
        require("dap").session()
      end
    '') "Session")
    (mkKeymap' "<leader>dt" (lib.nixvim.mkRaw ''
      function()
        require("dap").terminate()
      end
    '') "Terminate")
    (mkKeymap' "<leader>dw" (lib.nixvim.mkRaw ''
      function()
        require("dap.ui.widgets").hover()
      end
    '') "Widgets")
    (mkKeymap' "<leader>du" (lib.nixvim.mkRaw ''
      function()
        require("dapui").toggle({ })
      end
    '') "Dap UI")
    (mkKeymap ["n" "v"] "<leader>de" (lib.nixvim.mkRaw ''
      function()
        require("dapui").eval()
      end
    '') "Eval")
  ];
}
