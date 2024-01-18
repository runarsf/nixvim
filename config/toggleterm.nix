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
    
    function _gitui_toggle()
      gitui:toggle()
    end
    
    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _gitui_toggle()<CR>", {noremap = true, silent = true})
  '';
}
