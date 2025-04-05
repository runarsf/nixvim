{
  config,
  lib,
  ...
}:
{
  options.modules.hop.enable = lib.mkEnableOption "hop";

  config = lib.mkIf config.modules.hop.enable {
    plugins.hop = {
      enable = true;
      settings.keys = "etovxqpdygfblzhckisuran";
    };

    keymaps = [
      {
        key = "f";
        action = "<CMD>HopPattern<CR>";
        options.desc = "Hop (pattern)";
      }
      {
        key = "F";
        action = "<CMD>HopAnywhere<CR>";
        options.desc = "Hop";
      }
    ];
  };
}
