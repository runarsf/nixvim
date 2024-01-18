{ pkgs, ... }: {
  plugins.toggleterm = {
    enable = true;
    direction = "float";
    openMapping = "<M-n>";
    floatOpts.border = "curved";
  };

  extraConfigLuaPre = ''
    local Terminal  = require('toggleterm.terminal').Terminal
    local gitui = Terminal:new({ cmd = "${pkgs.gitui}/bin/gitui", hidden = true })

    function GituiToggle()
      gitui:toggle()
    end
  '';

  keymaps = [{
    key = "<leader>g";
    action = "<CMD>lua GituiToggle()<CR>";
  }];
}
