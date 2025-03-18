{
  config,
  lib,
  ...
}: {
  options.modules.dap.enable = lib.mkEnableOption "dap";

  config = lib.mkIf config.modules.dap.enable {
    plugins = {
      dap = {
        enable = true;
        signs.dapBreakpoint.text = "";
      };
      dap-ui.enable = true;
      dap-virtual-text.enable = true;

      cmp.settings.sources = [{name = "dap";}];
    };

    keymaps = [
      {
        key = "<leader>db";
        action = "<CMD>lua require('dap').toggle_breakpoint()<CR>";
        options.desc = "(debug) Add breakpoint";
      }
      {
        key = "<leader>ds";
        action = "<CMD>lua require('dap').continue()<CR>";
        options.desc = "(debug) Start / Continue";
      }
      {
        key = "<leader>do";
        action = "<CMD>lua require('dap').step_over()<CR>";
        options.desc = "(debug) Step over";
      }
      {
        key = "<leader>di";
        action = "<CMD>lua require('dap').step_into()<CR>";
        options.desc = "(debug) Step into";
      }
      {
        key = "<leader>dO";
        action = "<CMD>lua require('dap').step_out()<CR>";
        options.desc = "(debug) Step out";
      }
      {
        key = "<leader>dr";
        action = "<CMD>lua require('dap').repl.toggle()<CR>";
        options.desc = "(debug) REPL";
      }
      {
        key = "<leader>dS";
        action = "<CMD>lua require('dap').close()<CR>";
        options.desc = "(debug) Stop";
      }
      {
        key = "<leader>du";
        action = "<CMD>lua require('dapui').toggle()<CR>";
        options.desc = "(debug) Toggle UI";
      }
    ];
  };
}
