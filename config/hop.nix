{ pkgs, ... }:

{
  extraPlugins = [{
    plugin = pkgs.vimPlugins.hop-nvim;
    config = ''
      lua require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    '';
  }];
  keymaps = [
    {
      key = "s";
      action = "<CMD>HopPattern<CR>";
      options.desc = "Hop (pattern)";
    }
    {
      key = "S";
      action = "<CMD>HopAnywhere<CR>";
      options.desc = "Hop";
    }
  ];
}
