{
  config,
  lib,
  ...
}:
lib.mkModule config "hop" {
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
}
