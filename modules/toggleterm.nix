{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkModule config "toggleterm" {
  plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "float";
      open_mapping = "[[<M-n>]]";
      float_opts.border = "curved";
    };
  };

  extraConfigLuaPre = ''
    local Terminal = require('toggleterm.terminal').Terminal
      local gitui = Terminal:new({
        cmd = "${lib.getExe pkgs.gitui}",
        direction = "float",
        float_opts = {
          border = "curved",
        },
        hidden = true,
      })

    function GituiToggle()
      gitui:toggle()
    end
  '';

  keymaps = [
    {
      key = "<Leader>g";
      action = "<CMD>lua GituiToggle()<CR>";
      options.desc = "Toggle GitUI";
    }
  ];
}
