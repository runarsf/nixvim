{
  config,
  lib,
  pkgs,
  utils,
  ...
}: {
  options.modules.namu.enable = lib.mkEnableOption "namu";

  config = lib.mkIf config.modules.namu.enable {
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = namu-nvim;
        config = utils.luaToViml ''
          require("namu").setup()
        '';
      }
    ];

    keymaps = [
      {
        key = "<leader>s";
        action = ''<CMD>lua require("namu.namu_symbols").show<CR>'';
        mode = ["n"];
        options.desc = "Show symbols";
      }
    ];
  };
}
