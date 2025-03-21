{
  config,
  lib,
  ...
}: {
  options.modules.dap.enable = lib.mkEnableOption "dap";

  # TODO UI like this https://github.com/redyf/Neve/blob/main/assets/showcase4.png
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
        key = "<Leader>db";
        action = "<CMD>lua require('dap').toggle_breakpoint()<CR>";
        options.desc = "(debug) Add breakpoint";
      }
      {
        key = "<Leader>ds";
        action = "<CMD>lua require('dap').continue()<CR>";
        options.desc = "(debug) Start / Continue";
      }
      {
        key = "<Leader>do";
        action = "<CMD>lua require('dap').step_over()<CR>";
        options.desc = "(debug) Step over";
      }
      {
        key = "<Leader>di";
        action = "<CMD>lua require('dap').step_into()<CR>";
        options.desc = "(debug) Step into";
      }
      {
        key = "<Leader>dO";
        action = "<CMD>lua require('dap').step_out()<CR>";
        options.desc = "(debug) Step out";
      }
      {
        key = "<Leader>dr";
        action = "<CMD>lua require('dap').repl.toggle()<CR>";
        options.desc = "(debug) REPL";
      }
      {
        key = "<Leader>dS";
        action = "<CMD>lua require('dap').close()<CR>";
        options.desc = "(debug) Stop";
      }
      {
        key = "<Leader>du";
        action = "<CMD>lua require('dapui').toggle()<CR>";
        options.desc = "(debug) Toggle UI";
      }
    ];
  };
}
