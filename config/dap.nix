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
      options.desc = "(debug) Continue";
    }
    {
      key = "<leader>do";
      action = "<CMD>lua require'dap'.step_over()<CR>";
      options.desc = "(debug) Step over";
    }
    {
      key = "<leader>dr";
      action = "<CMD>lua require'dap'.repl.open()<CR>";
      options.desc = "(debug) REPL";
    }
  ];

  plugins = {
    dap = {
      enable = true;
      extensions.dap-ui.enable = true;
    };

    cmp.settings.sources = [
      { name = "dap"; }
    ];
  };
}
